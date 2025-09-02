{
  config,
  pkgs,
  lib,
  ...
}: {
  config = lib.mkIf config.features.gui.desktops.niri.enable {
    programs.niri.settings.binds = let
      left = "h";
      down = "j";
      up = "k";
      right = "l";
    in {
      # App Launching Keys
      "Mod+Q".action.spawn = ["foot"];
      "Mod+W".action.spawn = ["qutebrowser"];
      "Mod+Shift+W".action.spawn = ["librewolf"];
      "Mod+E".action.spawn = ["neovide"];

      # Reboot to gaming OS
      "Mod+G".action.spawn = ["${lib.getExe (pkgs.writers.writeNuBin "gameos" "pkexec ${pkgs.efibootmgr}/bin/efibootmgr --bootnext 0000; reboot")}"];

      # Clear Notifications
      "Mod+B".action.spawn = ["makoctl" "dismiss" "-a"];

      # Selectors
      "Mod+R".action.spawn = ["fuzzel"];
      "Mod+T".action.spawn = ["tool-selector"];
      "Mod+Y".action.spawn = ["clipboard-selector"];
      "Mod+U".action.spawn = ["wallpaper-selector" "--all-outputs"];
      "Mod+Shift+U".action.spawn = ["wallpaper-selector"];
      "Mod+Control+U".action.spawn = ["wallpaper-selector" "--randomize" "--all-outputs"];
      "Mod+Control+Shift+U".action.spawn = ["wallpaper-selector" "--randomize"];

      # Screenshot Keys
      "Mod+P".action.screenshot = [];
      "Shift+Mod+P".action.screenshot-screen = [];
      "Control+Mod+P".action.screenshot-window = [];

      # Power Keys
      "Mod+comma".action.spawn = ["${lib.getExe (pkgs.writers.writeNuBin "nirilock" "systemctl suspend ; hyprlock")}"];

      # Horizontal Tiling Keys
      "Mod+A".action.maximize-column = [];
      "Mod+S".action.switch-preset-column-width = [];

      # Vertical Tiling Keys
      "Mod+Shift+A".action.reset-window-height = [];
      "Mod+Shift+S".action.switch-preset-window-height = [];
      "Mod+D".action.consume-or-expel-window-right = [];

      # Floating Window Management Keys
      "Mod+Z".action.switch-focus-between-floating-and-tiling = [];
      "Mod+X".action.toggle-window-floating = [];

      # Other Window Management Keys
      "Mod+C".action.close-window = [];
      "Mod+V".action.fullscreen-window = [];

      # Overlay Keys
      "Mod+F".action.toggle-overview = [];

      # +---------------------+
      # | Arrow Movement Keys |
      # +---------------------+

      # Window Focus Keys
      "Mod+Left".action.focus-column-left = [];
      "Mod+Right".action.focus-column-right = [];
      "Mod+Up".action.focus-window-up = [];
      "Mod+Down".action.focus-window-down = [];

      # Monitor Focus Keys
      "Mod+Shift+Left".action.focus-monitor-left = [];
      "Mod+Shift+Right".action.focus-monitor-right = [];

      # Workspace Focus Keys
      "Mod+Shift+Up".action.focus-workspace-up = [];
      "Mod+Shift+Down".action.focus-workspace-down = [];

      # Window Motion Keys
      "Mod+Control+Left".action.move-column-left = [];
      "Mod+Control+Right".action.move-column-right = [];
      "Mod+Control+Up".action.move-window-up = [];
      "Mod+Control+Down".action.move-window-down = [];

      # Window - Monitor Motion Keys
      "Mod+Control+Shift+Left".action.move-column-to-monitor-left = [];
      "Mod+Control+Shift+Right".action.move-column-to-monitor-right = [];

      # Window - Workspace Motion Keys
      "Mod+Control+Shift+Up".action.move-window-to-workspace-up = [];
      "Mod+Control+Shift+Down".action.move-window-to-workspace-down = [];

      # Workspace Motion Keys
      "Mod+Alt+Shift+Up".action.move-workspace-up = [];
      "Mod+Alt+Shift+Down".action.move-workspace-down = [];

      # Workspace - Monitor Motion Keys
      "Mod+Alt+Shift+Left".action.move-workspace-to-monitor-left = [];
      "Mod+Alt+Shift+Right".action.move-workspace-to-monitor-right = [];

      # +-------------------+
      # | Vim Movement Keys |
      # +-------------------+

      # Window Focus Keys
      "Mod+${left}".action.focus-column-left = [];
      "Mod+${right}".action.focus-column-right = [];
      "Mod+${up}".action.focus-window-up = [];
      "Mod+${down}".action.focus-window-down = [];

      # Monitor Focus Keys
      "Mod+Shift+${left}".action.focus-monitor-left = [];
      "Mod+Shift+${right}".action.focus-monitor-right = [];

      # Workspace Focus Keys
      "Mod+Shift+${up}".action.focus-workspace-up = [];
      "Mod+Shift+${down}".action.focus-workspace-down = [];

      # Monitor Motion Keys
      "Mod+Control+Shift+${left}".action.move-column-to-monitor-left = [];
      "Mod+Control+Shift+${right}".action.move-column-to-monitor-right = [];

      # Workspace Motion Keys
      "Mod+Control+Shift+${up}".action.move-window-to-workspace-up = [];
      "Mod+Control+Shift+${down}".action.move-window-to-workspace-down = [];

      # Window Motion Keys
      "Mod+Control+${left}".action.move-column-left = [];
      "Mod+Control+${right}".action.move-column-right = [];
      "Mod+Control+${up}".action.move-window-up = [];
      "Mod+Control+${down}".action.move-window-down = [];

      # Workspace Motion Keys
      "Mod+Alt+Shift+${up}".action.move-workspace-up = [];
      "Mod+Alt+Shift+${down}".action.move-workspace-down = [];

      # Workspace - Monitor Motion Keys
      "Mod+Alt+Shift+${left}".action.move-workspace-to-monitor-left = [];
      "Mod+Alt+Shift+${right}".action.move-workspace-to-monitor-right = [];

      # +-------------------+

      # Numbered Workspace Movement Keys
      "Mod+1".action.focus-workspace = 1;
      "Mod+2".action.focus-workspace = 2;
      "Mod+3".action.focus-workspace = 3;
      "Mod+4".action.focus-workspace = 4;
      "Mod+5".action.focus-workspace = 5;
      "Mod+6".action.focus-workspace = 6;
      "Mod+7".action.focus-workspace = 7;
      "Mod+8".action.focus-workspace = 8;
      "Mod+9".action.focus-workspace = 9;
      "Mod+0".action.focus-workspace = 0;

      # XF86 Keys
      "XF86AudioRaiseVolume".action.spawn = ["wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%+"];
      "XF86AudioLowerVolume".action.spawn = ["wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%-"];
      "XF86AudioMute".action.spawn = ["wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle"];

      "XF86MonBrightnessUp".action.spawn = ["${lib.getExe pkgs.brightnessctl}" "s" "+5%"];
      "XF86MonBrightnessDown".action.spawn = ["${lib.getExe pkgs.brightnessctl}" "s" "5%-"];

      "XF86LaunchB".action.spawn = ["fuzzel"];
    };
  };
}
