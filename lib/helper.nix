{inputs}: let
  helper = (import ./helper.nix) {inherit inputs;};
in rec {
  # Library to shorten flake.

  # Package Helpers
  pkgsFor = sys: inputs.nixpkgs.legacyPackages.${sys};

  # Miscellaneous
  forAllSystems = inputs.nixpkgs.lib.genAttrs [
    "aarch64-linux"
    "x86_64-linux"
    "aarch64-darwin"
    "x86_64-darwin"
  ];

  # Create a custom packages overlat for use in configs. IDK HOW THIS WORKS BUT IT DOES
  customPackagesOverlay.nixpkgs.overlays = [
    (final: prev:
      import ../pkgs {
        pkgs = final;
        inherit inputs;
      })
  ];

  # Create custom packages set for exposure via flake.
  customPackages = forAllSystems (
    system:
      import ../pkgs {
        pkgs = inputs.nixpkgs.legacyPackages.${system};
        inherit inputs;
      }
  );

  # Get Custom Libraries
  umport = (import ./umport.nix {inherit (inputs.nixpkgs) lib;}).umport;

  # Configuration Buildables
  mkNixosSystem = system: architecture: (
    inputs.nixpkgs.lib.nixosSystem {
      specialArgs = {
        inherit inputs helper;
      };
      modules =
        [
          ../nixos/systems/${system}/system.nix
          ../nixos/modules
          customPackagesOverlay
        ]
        ++ umport {
          paths = [
            ../nixos/features
          ];
          recursive = true;
        };
      system = architecture;
    }
  );

  mkHomeManagerUser = user: system: architecture: (
    inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = pkgsFor architecture;
      extraSpecialArgs = {
        inherit inputs helper;
      };
      modules =
        [
          ../home-manager/users/${system}/${user}.nix
          ../home-manager/modules
          customPackagesOverlay
        ]
        ++ umport {
          paths = [
            ../home-manager/features
          ];
          recursive = true;
        };
    }
  );
}
