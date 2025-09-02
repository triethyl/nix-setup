{ config, pkgs, lib, ... }: let
  cfg = config.features.gui.apps.mpv;
in {
  options.features.gui.apps.mpv.enable = lib.mkEnableOption "mpv";
  config = lib.mkIf cfg.enable {
    programs.mpv = {
      enable = true;
      config = {
        # Change youtube downloader to yt-dlp for faster downloads.
        script-opts = "ytdl_hook-ytdl_path=${lib.getExe pkgs.yt-dlp}";
        # Download videos at 720p or lower.
        ytdl-format = "bestvideo[height<=720]+bestaudio/best[height<=720]";

        save-position-on-quit = false; # makes mpv audio only when true?

        osd-bar = false;
      };
      bindings = {
        "tab" = "script-binding uosc/toggle-ui";
      };
      scripts = with pkgs.mpvScripts; [
        uosc
        thumbfast
        sponsorblock
      ];
    };
  };
}
