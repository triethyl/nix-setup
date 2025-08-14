{config, ...}: {
  imports = [./hardware.nix];

  general-settings = {
    hostname = "thinkpad-laptop";
    locale = "en_US.UTF-8";
    timezone = "America/New_York";
    stateVersion = "24.11";
  };

  age.secrets.lucas-user-password.file = ../../secrets/lucas-user-password.age;

  users.users."lucas" = {
    hashedPasswordFile = config.age.secrets.lucas-user-password.path;
    isNormalUser = true;
    description = "lucas";
    extraGroups = [
      "networkmanager"
      "wheel"
      "audio"
      "video"
      "libvirtd"
    ];
  };

  features = {
    gui = {
      apps = {
        steam.enable = true;
        # vmware.enable = true;
      };
      desktops = {
        niri.enable = true;
      };
    };
    cli = {
      shells.nushell.enable = true;
      utils = {
        nh = {
          enable = true;
          flake = "/home/lucas/Sync/setup";
        };
      };
    };
    services = {
      core.systemd-boot.enable = true;
      hardware = {
        bluetooth.enable = true;
        iwd.enable = true;
        pipewire.enable = true;
      };
      extra = {
        plymouth.enable = true;
        sddm.enable = true;
        syncthing-client = {
          enable = true;
          username = "lucas";
        };
        udisks2.enable = true;
      };
      bundles = {
        printing.enable = true;
      };
    };
  };
}
