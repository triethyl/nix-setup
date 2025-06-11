{ config, lib, ... }: let
  cfg = config.features.cli.apps.zellij; 
in {
  options.features.cli.apps.zellij.enable = lib.mkEnableOption "zellij";
  config = lib.mkIf cfg.enable {
    programs.zellij = {
      enable = true;       
      settings = {
        pane_frames = true;
        ui.pane_frames.rounded_corners = true;
        simplified_ui = true;
        default_layout = "compact";
        hide_session_name = true;

        mouse_mode = false;

        on_force_close = "detach";
        session_serialization = true;
      };   
    };
  };
}
