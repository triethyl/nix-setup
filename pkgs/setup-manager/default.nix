{
  pkgs,
  lib,
}: let
  path = with pkgs; [
    nvd
    nix-output-monitor
  ];
in
  pkgs.writers.writeNuBin "setup" {
    makeWrapperArgs = [
      "--prefix"
      "PATH"
      ":"
      "${lib.makeBinPath path}"
    ];
  } (builtins.readFile ./setup.nu)
