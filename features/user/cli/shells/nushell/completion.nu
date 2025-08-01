# Carapace Autocomplete
let carapace_completer = {|spans|
  carapace $spans.0 nushell ...$spans | from json
}
$env.config = {
  completions: {
    case_sensitive: false
    quick: true
    partial: true
    algorithm: fuzzy
    external: {
      enable: true
      max_results: 100
      completer: $carapace_completer
    }
  }
}
