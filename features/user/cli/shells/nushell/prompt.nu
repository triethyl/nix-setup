# +---------------+
# | Prompt Config |
# +---------------+

# define segmants
def path_segment [] {
  let current_dir = pwd
  let truncated_current_dir = $current_dir
  return (pwd | str replace $env.home '~')
}
def git_segment [] {
  return (gitprompt-rs)
}
let do_newline = false # whether to do the newline thing
$env.PROMPT_COMMAND = {||
  # add a newline at the beginning if it isn't the first prompt
  mut newline = ""
  if ($env.CMD_DURATION_MS != '0823') and $do_newline {
    $newline = "\n"
  }
  # define the prompt
  return $"($newline)(ansi white) ╭ (ansi green_bold)(path_segment)(ansi reset) (git_segment)\n "
}

# remove right prompt section
$env.PROMPT_COMMAND_RIGHT = { "" }

# set default prompt indicator
$env.PROMPT_INDICATOR = $'(ansi white)╰ (ansi red_bold)> '
# $env.TRANSIENT_PROMPT_INDICATOR = $' (ansi red_bold)> '
$env.PROMPT_MULTILINE_INDICATOR = "   : "

# change prompt to a lambda if in a nix shell
let in_nix_shell = $env.path | str contains "/nix/store" | any {|el| $el}
if $in_nix_shell {
  $env.PROMPT_INDICATOR = $'(ansi white)╰ (ansi red_bold)λ '
}

# replace vi insert and normal mode prompt indicators with cursor changes
$env.PROMPT_INDICATOR_VI_NORMAL = $env.PROMPT_INDICATOR
$env.PROMPT_INDICATOR_VI_INSERT = $env.PROMPT_INDICATOR
$env.config.cursor_shape.vi_insert = "line"
$env.config.cursor_shape.vi_normal = "block"

# customize menus to match
$env.config.menus = [
  {
    name: help_menu
    only_buffer_difference: true # Search is done on the text written after activating the menu
    marker: $env.PROMPT_INDICATOR                 # Indicator that appears with the menu is active
    type: {
      layout: description      # Type of menu
      columns: 4               # Number of columns where the options are displayed
      col_width: 20            # Optional value. If missing all the screen width is used to calculate column width
      col_padding: 2           # Padding between columns
      selection_rows: 4        # Number of rows allowed to display found options
      description_rows: 10     # Number of rows allowed to display command description
    }
    style: {
      text: green                   # Text style
      selected_text: green_reverse  # Text style for selected option
      description_text: yellow      # Text style for description
    }
  }
  {
    name: completion_menu
    only_buffer_difference: false # Search is done on the text written after activating the menu
    marker: $env.PROMPT_INDICATOR                  # Indicator that appears with the menu is active
    type: {
      layout: columnar          # Type of menu
      columns: 4                # Number of columns where the options are displayed
      col_width: 20             # Optional value. If missing all the screen width is used to calculate column width
      col_padding: 2            # Padding between columns
    }
    style: {
      text: green                   # Text style
      selected_text: green_reverse  # Text style for selected option
      description_text: yellow      # Text style for description
    }
  }
  {
    name: history_menu
    only_buffer_difference: true # Search is done on the text written after activating the menu
    marker: $env.PROMPT_INDICATOR                 # Indicator that appears with the menu is active
    type: {
      layout: list             # Type of menu
      page_size: 10            # Number of entries that will presented when activating the menu
    }
    style: {
      text: green                   # Text style
      selected_text: green_reverse  # Text style for selected option
      description_text: yellow      # Text style for description
    }
  }
]
