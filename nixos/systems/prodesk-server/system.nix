{config, ...}: {
  imports = [./hardware.nix];

  # Configure general settings.
  general-settings = {
    hostname = "prodesk-server";
    locale = "en_US.UTF-8";
    timezone = "America/New_York";
    stateVersion = "23.11";
  };

  age.secrets.server-user-password.file = ../../../secrets/user-passwords/prodesk-server/server.age;

  # Configure admin user.
  users.users."server" = {
    hashedPasswordFile = config.age.secrets.server-user-password.path;
    isNormalUser = true;
    description = "Server";
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMcc7hXixElOgv87LlY1LgCQ9oOT6Lj66wjCh1uRqpQt culsans@nzxt-desktop"
    ];
    extraGroups = [
      "networkmanager"
      "wheel"
      "audio"
      "video"
    ];
  };

  # Enable features.
  features = {
    cli = {
      shells.nushell.enable = true;
      utils = {
        nh = {
          enable = true;
          flake = "/home/server/Sync/setup";
        };
      };
    };
    services = {
      core.systemd-boot.enable = true;
      extra = {
        udisks2.enable = true;
      };
    };
  };

  networking.domain = "culsans.site";

  # Configure homelab modules.
  homelab = {
    core = {
      ssh.enable = true;
      caddy.enable = true;
    };
    cloud = {
      syncthing = {
        enable = true;
        user = "server";
      };
    };
    dev = {
      git.enable = true;
    };
  };
} 
