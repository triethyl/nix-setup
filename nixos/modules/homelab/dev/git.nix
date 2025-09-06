{config, lib, pkgs, ...}: let
  cfg = config.homelab.dev.git;
in {
  options.homelab.dev.git = {
    enable = lib.mkEnableOption "git";
  };
  config = lib.mkIf cfg.enable {
    users.users."git" = {
      isSystemUser = true;
    };
    services.gitolite = {
      enable = true;
      user = "git";
      adminPubkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMcc7hXixElOgv87LlY1LgCQ9oOT6Lj66wjCh1uRqpQt culsans@nzxt-desktop";
      dataDir = "/srv/git";
    };
  };
}
