#!/usr/bin/env nu

# +---------------+
# | Configuration |
# +---------------+

# Default config options.
mut config = {
  notebook_dir: "~/Sync/notebook"
  journal_dir: "~/Sync/notebook/journal"
  trash_dir: "~/Sync/notebook/.trash"
}

# Read config options from environment variables.
if ((try {$env.spiral_notebook_dir}) != null) {
  $config.notebook_dir = $env.spiral_notebook_dir
}
if ((try {$env.spiral_journal_dir}) != null) {
  $config.journal_dir = $env.spiral_journal_dir
}
if ((try {$env.spiral_trash_dir}) != null) {
  $config.trash_dir = $env.spiral_trash_dir
}

# Make config immutable.
let config = $config

# +-------------+
# | Subcommands |
# +-------------+

# A commandline utility written in nushell to manage your markdown notebook!
def "main" [] {}

# Create a new note.
def "main new" [
  title?: string # The title of the new note.
  --no-frontmatter (-n) # Don't add a frontmatter to the note.
] {
  mut title = $title
  if ($title == null) {
    $title = get_string_input "Enter a title: "
  }  
  if $no_frontmatter {
    create_note --no-frontmatter $title
  } else {
    create_note $title
  }
}

# Open a pre-existing note.
def "main open" [
  --by-title (-t) # Filter notes by their title (disables preview)
  --by-contents (-c) # Search through the contents of the notebook.
  title?: string # The title of the note to open.
] {
  if ($by_title and $by_contents) {
    error make {msg: "Only one flag can be used at a time."}
  }
  if ($title != null) {
    if ((title_to_path $title) | path exists) {
      return (title_to_path $title)
    } else {
      if (confirm $"The note ($title) does not exist. Would you like to create it? ") {
        create_note $title
      }
    }
  } else if $by_title {
    edit $"(get_choice_from_note_titles --dir $config.notebook_dir)"
  } else if $by_contents {
    edit (get_choice_from_dir_file_contents --dir $config.notebook_dir)
  } else {
    edit $"(get_choice_from_dir --dir $config.notebook_dir)"
  }
}

# Open a note based on the tag.
def "main tags" [
  tag?: string # The tag to select a note from.
] {
  # This section of code creates nested records with tags and notes and stores them in $tag_record.
  let note_table = list_notes --dir $config.notebook_dir

  let tag_list = $note_table
    | get tags
    | flatten
    | where (($it != null) and ($it != ""))
 
  mut tag_record = {}

  print $tag_list
  for tag in $tag_list {
    mut notes = {}
    for note_path in ($note_table | get path) {
      let note_tags = ($note_table | where path == $note_path | get tags | flatten)
      let note_title = ($note_table | where path == $note_path | get title | to text | str trim)
      if ($note_tags != []) {
        for note_tag in $note_tags {
          if ($note_tag == $tag) {
            $notes = $notes | insert $note_title { $note_path }
          }
        }
      }
    }
    let notes = $notes
    # $tag_record = $tag_record | insert $tag { $notes }
  }

  # Actual logic of the subcommand
  if ($tag == null) {
    let user_tag_choice = get_choice_from_list --list $tag_list
    if ($user_tag_choice != "") {
      let note_record = $tag_record | get $user_tag_choice
      let user_note_title_choice = get_choice_from_list --list ($note_record | columns)
      if ($user_note_title_choice != "") {
        edit ($note_record | get $user_note_title_choice)
      }
    }
  } else {
    if ($tag_list | any {|item| $item == $tag}) {
      let note_record = $tag_record | get $tag
      let user_note_title_choice = get_choice_from_list --list ($note_record | columns)
      if ($user_note_title_choice != "") {
        edit ($note_record | get $user_note_title_choice)
      }
    } else {
      print $"The tag '($tag)' does not exist."
    }
  }
}

# Get a table of notes and their properties.
def "main list" [] {
  return (list_notes --dir $config.notebook_dir)
}

# Send a note to the trash.
def "main remove" [
  --by-title (-t) # Filter notes by their title (disables preview)
  --by-contents (-c) # Search through the contents of the notebook.
  title?: string # The title of the note to send to the trash.
] {
  if ($by_title and $by_contents) {
    error make {msg: "Only one flag can be used at a time."}
  }
  if ($title != null) {
    if ((title_to_path $title) | path exists) {
      return (title_to_path $title)
    } else {
      if (confirm $"The note ($title) does not exist. Would you like to create it? ") {
        create_note $title
      }
    }
  } else if $by_title {
    mv (select_note --by-title --dir $config.notebook_dir)
  } else if $by_contents {
    ^$env.editor (select_note --by-contents --dir $config.notebook_dir)
  } else {
    ^$env.editor (select_note --dir $config.notebook_dir)
  }
}

# Explains how to configural Spiral.
def "main config" [] {
  print "The default options:"
  print $config
  print "These can be modified by editing the environment variables corresponding to each option. For example, to change the notebook directory, set $env.spiral_notebook_dir='~/custom-dir/notebook'."
}

# +------------------+
# | Action Functions |
# +------------------+

def create_note [--no-frontmatter, title: string] {
  let note_path = title_to_path $title
  if ($note_path | path exists) {
    if (confirm "This note already exists. Would you like to open it?") {
      edit $note_path
    } else {exit}
  } else {
    if $no_frontmatter {
      generate_note_text --no-frontmatter --title $title | save $note_path
    } else {
      generate_note_text --title $title | save $note_path
    }
    edit $"($note_path):100:100"
  }
}

def create_journal_entry [
  
] {
  
}

def edit [
 file_path: string
] {
  if (($file_path | path type) == file) {
    ^$env.editor ($file_path | path expand)
  }
}

# +---------------------+
# | Interface Functions |
# +---------------------+

def get_string_input [prompt: string] {
  print $prompt
  return (input)
}

def get_confirmation [prompt: string] {
  print $"($prompt) \(Y/n)"
  let confirmation = (input | str downcase)
  if ($confirmation == "n" ) {
    return false
  } else {return true}
}

def get_choice_from_list [ --list: list ] {
  return (($list | to text) | tv)
} # -> string

def get_choice_from_dir [ --dir: string ] {
  return $"($config.notebook_dir | path expand)/(tv files ($dir | path expand))"
} # -> full path

def get_choice_from_dir_file_contents [ --dir: string ] {
  return $"($config.notebook_dir | path expand)/(tv text ($dir | path expand))"
} # -> full path: line number

def get_choice_from_note_titles [ --dir: string ] {
  let note_table = list_notes --dir $config.notebook_dir
  let user_choice = get_choice_from_list --list ($note_table | get title)
  let user_choice_path = (
    $note_table
    | where title == $user_choice
    | get path
    | to text
    | str trim
  )
  if (($user_choice_path | path type) == file) {
    return $user_choice_path
  }
} # -> full path

# +-------------------------------+
# | String Manipulation Functions |
# +-------------------------------+

def title_to_path [title: string] {
  return (
    $"($config.notebook_dir)/($title | str kebab-case).md"
    | path expand
  )
} # -> full path

def strip_line_number [string: string] {
  return (
    $string
    | split row ":"
    | select 0
    | to text
    | str trim
  )
} # -> string

def generate_note_text [
  --no-frontmatter
  --title: string
] {
  if $no_frontmatter {
    return $"# ($title)\n"
  } else {
    let frontmatter_info = {
      title: $title
      date: (date now)
      lang: "en-US"
      tags: ['note']
    }
    return $"---\n($frontmatter_info | to yaml)---\n\n# ($title)"
  }
} # -> string

# +-----------------------------+
# | File Manipulation Functions |
# +-----------------------------+

def list_notes [--dir: string] {
  return ((
    ls ($dir | path expand)
    | where type == file
    | get name
  ) | par-each {
    |note_path|
    let frontmatter = parse_frontmatter $note_path
    if ($frontmatter != null) {
      return {
        title: (try {$frontmatter.title})
        path: $note_path
        tags: (try {$frontmatter.tags})
        date: (try {$frontmatter.date})
        lang: (try {$frontmatter.lang})
      }
    }
  })
} # -> table

def parse_frontmatter [path: string] {
  let frontmatter = try {
    open ($path | path expand)
    | split row "---"
    | get 1
    | from yaml
  }
  if ($frontmatter == null) {
    let title = try {
      open ($path | path expand)
      | split row "#"
      | get 1
      | split row "\n"
      | get 0
      | str trim
    }
    return {title: $title}
  }
  return $frontmatter
} # -> record
