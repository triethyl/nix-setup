{config, ...}: {
  imports = [./hardware.nix];

  general-settings = {
    hostname = "nzxt-desktop";
    locale = "en_US.UTF-8";
    timezone = "America/New_York";
    stateVersion = "23.11";
  };

  age.secrets.culsans-user-password.file = ../../secrets/culsans-user-password.age;

  users.users."culsans" = {
    hashedPasswordFile = config.age.secrets.culsans-user-password.path;
    isNormalUser = true;
    description = "Culsans";
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
        vmware.enable = false;
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
          flake = "/home/culsans/Sync/setup";
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
          username = "culsans";
        };
        udisks2.enable = true;
      };
      bundles = {
        printing.enable = true;
      };
    };
  };
}
