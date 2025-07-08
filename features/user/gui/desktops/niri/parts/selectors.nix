{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.features.gui.desktops.niri.parts.selectors;
  aes = config.aesthetics;
in {
  options.features.gui.desktops.niri.parts.selectors.enable = lib.mkEnableOption "selectors";
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      # Tool Selector
      (
        pkgs.writers.writeNuBin "tool-selector"
        /*
        nu
        */
        ''

          # Tools
          let tools = {
            "rebuild nixos": {
              # footclient -H sudo nixos-rebuild switch --flake ($"~/Sync/setup#(hostname)" | path expand)
              foot -H nh os switch
            }
            "rebuild home": {
              # foot -H home-manager switch --flake ($"~/Sync/setup#(whoami)@(hostname)" | path expand)
              foot -H nh home switch
            }
            "update flake": {
              foot -H nix flake update --flake ($"~/Sync/setup/" | path expand)
            }
            "manage wifi": {
              foot ${pkgs.impala}/bin/impala
            }
            "manage bluetooth": {
              foot ${lib.getExe pkgs.bluetui}
            }
            "create qr-code": {
              let temp_file = mktemp
              let qr_code_bin = ${lib.getExe pkgs.qrtool} encode (${pkgs.wl-clipboard}/bin/wl-paste)
              $qr_code_bin | ${pkgs.wl-clipboard}/bin/wl-copy
              $qr_code_bin | save -f $temp_file
              ${lib.getExe pkgs.imv} $temp_file
            }
            "steam big-picture": {
              rm -r ~/.steam
              gamescope -f --backend sdl -- steam -bigpicture
            }
          }

          # Logic
          let user_tool_choice = $tools
            | columns
            | to text
            | fuzzel -d --placeholder "Tools"
          if ($user_tool_choice != "") {
            do ($tools | get $user_tool_choice)
          }

        ''
      )

      # Wallpaper Selector
      (
        writers.writeNuBin "wallpaper-selector"
        /*
        nu
        */
        ''
          def main [
            --all-outputs # Change wallpaper for all outputs
            --randomize
          ] {
            mut wallpapers = {}
            for path in (ls ${aes.wallpapersDir}/**/* | where {|item| $item.type != dir} | get name) {
              $wallpapers = $wallpapers | insert ($path | path basename | split row "." | get 0) $path
            }
            mut prompt = "Wallpaper (current)"
            if $all_outputs {
              $prompt = "Wallpaper (all)"
            }
            mut wallpaper_path = ""
            if $randomize {
              $wallpaper_path = $wallpapers | get (
                $wallpapers
                  | columns
                  | shuffle
                  | get 0
              )
            } else {
              $wallpaper_path = $wallpapers | get (
                $wallpapers
                  | columns
                  | to text
                  | ${lib.getExe pkgs.fuzzel} -d --placeholder $prompt
              )
            }
            if $all_outputs {
              ${lib.getExe pkgs.swww} img $wallpaper_path -t wipe --transition-fps 60 --transition-angle 45
            } else {
              let focused_display = niri msg -j focused-output
                | from json
                | get name
              ${lib.getExe pkgs.swww} img $wallpaper_path -t wipe --transition-fps 60 --transition-angle 45 --outputs $focused_display
            }
          }
        ''
      )

      # Clipboard Selector
      (
        writers.writeNuBin "clipboard-selector" ''
          ${lib.getExe pkgs.cliphist} list
            | cut -f 2-
            | ${lib.getExe pkgs.fuzzel} --dmenu
            | ${pkgs.wl-clipboard}/bin/wl-copy
        ''
      )
    ];
  };
}
