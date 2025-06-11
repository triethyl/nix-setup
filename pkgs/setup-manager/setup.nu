# Aims of this program:
#
# Subcommands:
# - sync system {system name?}: rebuild system
# - sync user {home name?}: rebuild home
# - sync all {system @ home name?}: rebuild home and system
# - update: update the flake
# - vm {system name}: create and run a test vm
# - repl: open a nix repl with flake inputs
# - gc {what to remove?}: collect garbage

# Settings
let flake_dir = "~/Sync/setup/" | path expand
let default_system = hostname
let default_user = whoami


def "main" [] {}

# +-------------------------+
# | Syncronization Commands |
# +-------------------------+

def "main sync" [] {}

# Syncronize the system with its config.
def "main sync system" [
  system?: string # The name of the system config to syncronize.
] {
  sudo nixos-rebuild switch --flake $"($flake_dir)#($system | default $default_system)"
}

# Syncronize the userland with its config.
def "main sync user" [
  user?: string # The name of the user config to syncronize.
  system?: string # The name of the system the user falls under.
] {
  home-manager switch --flake $"($flake_dir)#($user | default $default_user)@($system | default $default_system)"
}

# Syncronize both the system and the userland with their configs.
def "main sync all" [
  usr_sys?: string # The name of the user and system configs to syncronize. In the format "user@system".
] {
  main sync system ; main sync user
}

# +----------------+
# | Other Commands |
# +----------------+

# Update the flake lock file according to its inputs.
def "main update" [] {}

# Create and run a test VM based on a system config.
def "main vm" [
  sys: string # The system config to base the VM on.
] {}

# Open a nix REPL including flake inputs.
def "main repl" [] {}

# Garbage collect the system.
def "main gc" [] {}
