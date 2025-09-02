{
  config,
  inputs,
  ...
}: {
  imports = [./hardware.nix inputs.jovian.nixosModules.jovian];

  general-settings = {
    hostname = "steam-deck";
    locale = "en_US.UTF-8";
    timezone = "America/New_York";
    stateVersion = "25.05";
  };

  # age.secrets.culsans-user-password.file = ../../secrets/culsans-user-password.age;

  users.users."culsans" = {
    # hashedPasswordFile = config.age.secrets.culsans-user-password.path;
    password = "hello";
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
      apps = {};
      desktops = {
        niri.enable = true;
      };
    };
    cli = {
      shells.nushell.enable = true;
      utils = {};
    };
    services = {
      core.systemd-boot.enable = true;
      hardware = {
        bluetooth.enable = true;
        networkmanager.enable = true;
        pipewire.enable = true;
      };
      extra = {
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

  jovian = {
    devices.steamdeck.enable = true;
    steam = {
      enable = true;
      autoStart = true;
      defaultSession = "niri";
      user = "culsans";
    };
  };
}
