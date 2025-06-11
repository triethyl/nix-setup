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
          def projinit [path?: string] {
            mut path = $path
            if ($path == null) {
              $path = "./"
            }
            let path = $path | path expand
            cp -r ${./direnv-project-template}/* $path
            chmod +w $"($path)/"
            direnv allow
          }

          # Quickly create a nix shell.
          def qs [...pkgs] {
            if $pkgs == [] {
              print "Please use a package name."
              return
            }
            let pkgs_string = $pkgs
              | each {|pkg| return $"nixpkgs#($pkg) "}
              | str join
              | str trim
            nu -c $"nix shell ($pkgs_string)"
          }

          # Quickly run a nix package.
          def qr [pkg: string] {
            nix run $"nixpkgs#($pkg)"
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
