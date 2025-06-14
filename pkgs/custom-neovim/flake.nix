{
  description = "Project flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    systems.url = "github:nix-systems/default";
    flake-utils = {
      url = "github:numtide/flake-utils";
      inputs.systems.follows = "systems";
    };
    mnw.url = "github:Gerg-L/mnw";
  };

  outputs = {
    nixpkgs,
    flake-utils,
    ...
  } @ inputs:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = nixpkgs.legacyPackages.${system};
      in {
        packages.default = pkgs.callPackage ./default.nix {inherit inputs;};
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            fennel
            fennel-ls
            luaPackages.readline
          ];
        };
      }
    );
}
