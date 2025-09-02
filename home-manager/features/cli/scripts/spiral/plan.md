# Spiral Plan

## Main Functions

Are ran by the user.

- `main new (--no-frontmatter (-n)) (title: <string>)`
- `main open (--by-title (-t)) (--by-contents (-c)) (title: <string>)`
- `main tags (tag: <string>)`
- `main remove (--by-title (-t)) (--by-contents (-c)) (title: <string>)` 
- `main list`
- `main restore (--by-title (-t)) (--by-contents (-c)) (title: <string>)`
- `main journal (date: <string>)`

## Action Functions

Accept parameters and perform an action.

- `create_note (--no-frontmatter) --title <string>`
- `create_journal_entry --title <string>`
- `open_file_in_editor --dir <dir>`

## Interface Functions

Accept a prompt and other data and return a value from the user.

- `get_confirmation --prompt <string> -> bool`
- `get_string_input --prompt <string> -> string`
- `get_choice_from_list --list <list> -> string`
- `get_choice_from_dir --dir <dir> -> path`
- `get_choice_from_dir_file_contents --dir <dir> -> path: line number`
- `get_choice_from_note_titles --dir <dir> -> path`

## String Manipulation Functions

Accept, modify, and return strings.

- `title_to_path title: <string> -> path`
- `strip_line_number string: <string> -> string`
- `generate_note_text (--no-frontmatter) --title <string> -> string`

## File Manipulation Functions

Read, write, or otherwise manipulate files.

- `parse_note_frontmatter path: <path> -> record`
- `list_notes -> table`
