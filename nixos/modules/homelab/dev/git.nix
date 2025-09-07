{config, lib, pkgs, ...}: let
  cfg = config.homelab.dev.git;
  full-domain = lib.strings.concatStrings [cfg.subdomain "." cfg.domain];
in {
  options.homelab.dev.git = {
    enable = lib.mkEnableOption "git";
    domain = lib.mkOption {
      description = "The domain under which to serve the git server.";
      type = lib.types.str;
      default = config.networking.domain;
      example = "example.com";
    };
    subdomain = lib.mkOption {
      description = "The subdomain under which to serve the git server.";
      type = lib.types.str;
      default = "git";
      example = "cgit";
    };
  };
  config = lib.mkIf cfg.enable {
    users.users."git" = {
      isSystemUser = true;
      description = lib.mkForce "git user";
      home = "/srv/git";
      shell = "${pkgs.git}/bin/git-shell";
      extraGroups = [ "git" ];
    };
    services.gitolite = {
      enable = true;
      user = "git";
      group = "git";
      adminPubkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMcc7hXixElOgv87LlY1LgCQ9oOT6Lj66wjCh1uRqpQt culsans@nzxt-desktop";
      dataDir = "/srv/git";
    };
    environment.etc."cgitrc".source = pkgs.writeText "cgitrc" (lib.generators.toKeyValue { } {
      css = "/cgit.css";
      # logo = "/cgit.png";

      about-filter = "${pkgs.cgit-pink}/lib/cgit/filters/about-formatting.sh";
      # source-filter = "${pkgs.cgit-pink}/lib/cgit/filters/syntax-highlighting.py";
      source-filter = lib.getExe pkgs.bat;

      clone-url = (lib.concatStringsSep " " [
        "https://$HTTP_HOST$SCRIPT_NAME/$CGIT_REPO_URL"
        "ssh://git@${full-domain}:$CGIT_REPO_URL"
      ]);

      enable-log-filecount = 1;
      enable-log-linecount = 1;

      enable-git-config = 1;

      root-title = full-domain;
      root-desc = "Culsans's Git Repositories";

      scan-path = "/srv/git/repositories";
    });
    services.fcgiwrap.instances."cgit" = {
      process = {
        user = "git";
        group = "git";
      };
      socket = {
        mode = "0660";
        group = "git";
        user = "git";
      };
    };

    # Configure caddy
    services.caddy.virtualHosts.${full-domain}.extraConfig = ''
      @assets path /cgit.css /cgit.js /cgit.png /favicon.ico /robots.txt
      handle @assets {
        root * /srv/www/${full-domain}
        file_server
      }

      reverse_proxy unix//run/fcgiwrap-cgit.sock {
        transport fastcgi {
          env SCRIPT_FILENAME ${pkgs.cgit}/cgit/cgit.cgi
        }
      }
    '';
    users.users."caddy".extraGroups = [ "git" ];
  };
}
