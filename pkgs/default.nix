{
  pkgs,
  inputs,
  ...
}: {
  custom-hello = pkgs.callPackage ./custom-hello.nix {};
  setup-manager = pkgs.callPackage ./setup-manager {};
  custom-neovim = pkgs.callPackage ./custom-neovim {inherit inputs;};
  old-custom-neovim = pkgs.callPackage ./old-custom-neovim {inherit inputs;};
}
