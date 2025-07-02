{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.features.cli.shells.nushell;
in {
  options.features.cli.shells.nushell.enable = lib.mkEnableOption "nushell";
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      television
      gitprompt-rs
    ];
    programs.nushell = {
      enable = true;
      plugins = with pkgs.nushellPlugins; [
        gstat
      ];
      shellAliases = {
        "nix-shell" = "nix-shell --command 'SHELL=nu nu'";
        "cd" = "z";
        "ze" = "zellij";
        "lg" = "lazygit";
        "bk" = "cd $env.OLDPWD";
        "fg" = "job unfreeze";
      };
      configFile.text =
        /*
        nu
        */
        ''
          # Source modularized configs.
          source ${./prompt.nu}
          source ${./completion.nu}

          # General Config
          $env.config = {
            show_banner: false
            edit_mode: 'vi'

            history: {
              isolation: true # Isolate the history of each nushell session
              file_format: sqlite # Required for isolation
            }
          }
          $env.editor = "hx"

          # go should use a hidden directory
          $env.gopath = "${config.home.homeDirectory}/.go"

          # Use direnv if present.
          { ||
            if (which direnv | is-empty) {
              return
            }
            direnv export json | from json | default {} | load-env

          }

          # define a function to initialize a direnv project
          def projinit [path?: string] { # this code sucks but I'm tired of working on it
            mut path = $path
            if ($path == null) {
              $path = "./"
            }
            let path = $path | path expand
            let template_path = "${./direnv-project-template}" | path expand
            let template_files = ls -a $template_path | get name
            $template_files | each {|item| cp $item $path}
            ls -a $path | get name | where {|name| $template_files | str contains ($name | path basename) | any {}} | each {|name| chmod +w $name}
            if (try {git rev-parse --is-inside-work-tree e> /dev/null}) != null {
              direnv allow
            } else {
              git init
              direnv allow
            }
            git add $"($path)/."
            git commit -m "initialized"
          }

          # Quickly create a nix shell.
          def qs [...packages] {
            if $packages == [] {
              print "Please use a package name."
              return
            }
            let packages_string = $packages
              | each {|package| return $"nixpkgs#($package) "}
              | str join
              | str trim
            nu -c $"nix shell ($packages_string)"
          }

          # Quickly run a nix package.
          def qr --wrapped [package: string ...arguments] {
            nix run $"nixpkgs#($package)" -- ($arguments | str join " ")
          }
        '';
    };
    programs.zoxide.enable = true;
    programs.carapace.enable = true;
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
      silent = true;
    };
  };
}
