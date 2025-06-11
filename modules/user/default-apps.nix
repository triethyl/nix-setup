{ config, lib, ... }: 
let
  cfg = config.default-applications;
  mkCommand = name: lib.mkOption {
    type = lib.types.str;
    default = "";
    description = "The default ${name}.";
  };
  mkDesktopFile = name: lib.mkOption {
    type = lib.types.str;
    default = "";
    description = "The default ${name}'s .desktop file";
  };
in {
  options.default-applications = {
    web-browser = {
      command = mkCommand "web browser";
      desktop-file = mkDesktopFile "web browser";
    };
    text-editor = {
      command = mkCommand "text editor";
      desktop-file = mkDesktopFile "text editor";
    };
    image-viewer = {
      command = mkCommand "image viewer";
      desktop-file = mkDesktopFile "image viewer";
    };
    video-viewer = {
      command = mkCommand "video viewer";
      desktop-file = mkDesktopFile "video viewer";
    };
    terminal-emulator = {
      command = mkCommand "terminal emulator";
      runTuiCommand = mkCommand "terminal emulator run tui command";
      runCliCommand = mkCommand "terminal emulator run cli command";
      desktop-file = mkDesktopFile "terminal emulator";
    };
  };
  config = {
    xdg.mimeApps = {
      enable = true;
      defaultApplications = {
        "text/plain" = [ cfg.text-editor.desktop-file ];
        "text/html" = [ cfg.text-editor.desktop-file ];
        "text/nix" = [ cfg.text-editor.desktop-file ];
      };
    };
  };
}
