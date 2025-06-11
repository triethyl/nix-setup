{
  pkgs,
  inputs,
  ...
}: {
  custom-hello = pkgs.callPackage ./custom-hello.nix {};
  custom-neovim = pkgs.callPackage ./custom-neovim {inherit inputs;};
  setup-manager = pkgs.callPackage ./setup-manager {};
}
