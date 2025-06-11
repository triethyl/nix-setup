{
  description = "System Flake";

  outputs = inputs: let
    helper = import ./lib/helper.nix {inherit inputs;};
  in {
    # NixOS Configurations
    nixosConfigurations = {
      "nzxt-desktop" = helper.mkSystem "nzxt-desktop" "x86_64-linux";
      "ideapad-laptop" = helper.mkSystem "ideapad-laptop" "x86_64-linux";
      "prodesk-server" = helper.mkSystem "prodesk-server" "x86_64-linux";
      "steam-deck" = helper.mkSystem "steam-deck" "x86_64-linux";
    };

    # Home Manager Configurations
    homeConfigurations = {
      "culsans@nzxt-desktop" = helper.mkHome "culsans" "nzxt-desktop" "x86_64-linux";
      "lucas@ideapad-laptop" = helper.mkHome "lucas" "ideapad-laptop" "x86_64-linux";
      "server@prodesk-server" = helper.mkHome "server" "prodesk-server" "x86_64-linux";
      "culsans@steam-deck" = helper.mkHome "culsans" "steam-deck" "x86_64-linux";
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

    mnw.url = "github:Gerg-L/mnw";

    niri.url = "github:sodiboo/niri-flake";

    nix-minecraft.url = "github:Infinidoge/nix-minecraft";

    ignis.url = "github:linkfrg/ignis";

    nix-flatpak.url = "github:gmodena/nix-flatpak";
  };
}
