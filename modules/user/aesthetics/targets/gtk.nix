{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.aesthetics.targets.gtk;
  aes = config.aesthetics;

  gtkCSS = with aes.scheme; ''
    @define-color accent_color #${base0D};
    @define-color accent_bg_color #${base0D};
    @define-color accent_fg_color #${base00};
    @define-color destructive_color #${base08};
    @define-color destructive_bg_color #${base08};
    @define-color destructive_fg_color #${base00};
    @define-color success_color #${base0B};
    @define-color success_bg_color #${base0B};
    @define-color success_fg_color #${base00};
    @define-color warning_color #${base0E};
    @define-color warning_bg_color #${base0E};
    @define-color warning_fg_color #${base00};
    @define-color error_color #${base08};
    @define-color error_bg_color #${base08};
    @define-color error_fg_color #${base00};
    @define-color window_bg_color #${base00};
    @define-color window_fg_color #${base05};
    @define-color view_bg_color #${base00};
    @define-color view_fg_color #${base05};
    @define-color headerbar_bg_color #${base01};
    @define-color headerbar_fg_color #${base05};
    @define-color headerbar_border_color #${base01}
    @define-color headerbar_backdrop_color @window_bg_color;
    @define-color headerbar_shade_color rgba(0, 0, 0, 0.07);
    @define-color headerbar_darker_shade_color rgba(0, 0, 0, 0.07);
    @define-color sidebar_bg_color #${base01};
    @define-color sidebar_fg_color #${base05};
    @define-color sidebar_backdrop_color @window_bg_color;
    @define-color sidebar_shade_color rgba(0, 0, 0, 0.07);
    @define-color secondary_sidebar_bg_color @sidebar_bg_color;
    @define-color secondary_sidebar_fg_color @sidebar_fg_color;
    @define-color secondary_sidebar_backdrop_color @sidebar_backdrop_color;
    @define-color secondary_sidebar_shade_color @sidebar_shade_color;
    @define-color card_bg_color #${base01};
    @define-color card_fg_color #${base05};
    @define-color card_shade_color rgba(0, 0, 0, 0.07);
    @define-color dialog_bg_color #${base01};
    @define-color dialog_fg_color #${base05};
    @define-color popover_bg_color #${base01};
    @define-color popover_fg_color #${base05};
    @define-color popover_shade_color rgba(0, 0, 0, 0.07);
    @define-color shade_color rgba(0, 0, 0, 0.07);
    @define-color scrollbar_outline_color #${base02};
    @define-color blue_1 #${base0D};
    @define-color blue_2 #${base0D};
    @define-color blue_3 #${base0D};
    @define-color blue_4 #${base0D};
    @define-color blue_5 #${base0D};
    @define-color green_1 #${base0B};
    @define-color green_2 #${base0B};
    @define-color green_3 #${base0B};
    @define-color green_4 #${base0B};
    @define-color green_5 #${base0B};
    @define-color yellow_1 #${base0A};
    @define-color yellow_2 #${base0A};
    @define-color yellow_3 #${base0A};
    @define-color yellow_4 #${base0A};
    @define-color yellow_5 #${base0A};
    @define-color orange_1 #${base09};
    @define-color orange_2 #${base09};
    @define-color orange_3 #${base09};
    @define-color orange_4 #${base09};
    @define-color orange_5 #${base09};
    @define-color red_1 #${base08};
    @define-color red_2 #${base08};
    @define-color red_3 #${base08};
    @define-color red_4 #${base08};
    @define-color red_5 #${base08};
    @define-color purple_1 #${base0E};
    @define-color purple_2 #${base0E};
    @define-color purple_3 #${base0E};
    @define-color purple_4 #${base0E};
    @define-color purple_5 #${base0E};
    @define-color brown_1 #${base0F};
    @define-color brown_2 #${base0F};
    @define-color brown_3 #${base0F};
    @define-color brown_4 #${base0F};
    @define-color brown_5 #${base0F};
    @define-color light_1 #${base01};
    @define-color light_2 #${base01};
    @define-color light_3 #${base01};
    @define-color light_4 #${base01};
    @define-color light_5 #${base01};
    @define-color dark_1 #${base01};
    @define-color dark_2 #${base01};
    @define-color dark_3 #${base01};
    @define-color dark_4 #${base01};
    @define-color dark_5 #${base01};
  '';
in {
  options.aesthetics.targets.gtk.enable = lib.mkOption {
    type = lib.types.bool;
    default = (aes.enableAllTargets && aes.hasGui);
    description = "Whether to enable the aesthetics GTK target.";
  };
  config = lib.mkIf cfg.enable {
    gtk = {
      enable = true;
      theme = {
        package = pkgs.adw-gtk3;
        name = "adw-gtk3";
      };
    };
    xdg.configFile = {
      "gtk-3.0/gtk.css".text = gtkCSS;
      "gtk-4.0/gtk.css".text = gtkCSS;
    };
  };
}
