{
  description = "System Flake";

  outputs = inputs: let
    helper = import ./lib/helper.nix {inherit inputs;};
  in {
    # NixOS Configurations
    nixosConfigurations = {
      "nzxt-desktop" = helper.mkNixosSystem "nzxt-desktop" "x86_64-linux";
      "thinkpad-laptop" = helper.mkNixosSystem "thinkpad-laptop" "x86_64-linux";
      "prodesk-server" = helper.mkNixosSystem "prodesk-server" "x86_64-linux";
      "steam-deck" = helper.mkNixosSystem "steam-deck" "x86_64-linux";
    };

    # Home Manager Configurations
    homeConfigurations = {
      "culsans@nzxt-desktop" = helper.mkHomeManagerUser "culsans" "nzxt-desktop" "x86_64-linux";
      "lucas@thinkpad-laptop" = helper.mkHomeManagerUser "lucas" "thinkpad-laptop" "x86_64-linux";
      "server@prodesk-server" = helper.mkHomeManagerUser "server" "prodesk-server" "x86_64-linux";
      "culsans@steam-deck" = helper.mkHomeManagerUser "culsans" "steam-deck" "x86_64-linux";
    };

    # Packages
    packages = helper.customPackages;
  };

  inputs = {
    # Essential (Nix Ecosystem)

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    jovian.url = "github:Jovian-Experiments/Jovian-NixOS"; # nixos on steam deck

    agenix.url = "github:ryantm/agenix";

    # Nonessential

    wallpapers.url = "git+https://codeberg.org/triethyl/wallpapers";

    mnw.url = "github:Gerg-L/mnw";

    niri.url = "github:sodiboo/niri-flake";

    nix-minecraft.url = "github:Infinidoge/nix-minecraft";

    nix-flatpak.url = "github:gmodena/nix-flatpak";
  };
}
