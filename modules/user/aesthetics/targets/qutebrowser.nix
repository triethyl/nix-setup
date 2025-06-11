{
  config,
  lib,
  ...
}: let
  cfg = config.aesthetics.targets.qutebrowser;
  aes = config.aesthetics;
in {
  options.aesthetics.targets.qutebrowser.enable = lib.mkOption {
    type = lib.types.bool;
    default = aes.enableAllTargets && aes.hasGui;
    description = "Whether to enable the aesthetics qutebrowser target.";
  };
  config = lib.mkIf (cfg.enable && config.programs.qutebrowser.enable) {
    programs.qutebrowser.settings = {
      fonts = {
        default_family = aes.font.name;
        default_size = "${aes.font.size.small}pt";
      };
      colors = with aes.scheme; let
        background = "#${base00}";
        secondary-background = "#${base01}";
        selection-background = "#${base03}";
        foreground = "#${base05}";
        inverted-foreground = "#${base00}";
        error = "#${base08}";
        info = "#${base0B}";
        secondary-info = "#${base0C}";
        warning = "#${base0E}";
      in {
        completion = {
          category = {
            bg = background;
            fg = info;
            border = {
              bottom = background;
              top = background;
            };
          };
          even.bg = background;
          fg = foreground;
          item.selected = {
            bg = selection-background;
            border = {
              bottom = selection-background;
              top = selection-background;
            };
            fg = foreground;
          };
          match.fg = info;
          odd.bg = secondary-background;
          scrollbar = {
            bg = background;
            fg = foreground;
          };
        };
        contextmenu = {
          disabled = {
            bg = secondary-background;
            fg = inverted-foreground;
          };
          menu = {
            bg = background;
            fg = foreground;
          };
          selected = {
            bg = selection-background;
            fg = foreground;
          };
        };
        downloads = {
          bar.bg = background;
          error = {
            bg = error;
            fg = inverted-foreground;
          };
          start = {
            bg = info;
            fg = inverted-foreground;
          };
          stop = {
            bg = secondary-info;
            fg = inverted-foreground;
          };
        };
        hints = {
          bg = secondary-background;
          fg = foreground;
          match.fg = info;
        };
        keyhint = {
          bg = background;
          fg = foreground;
          suffix.fg = foreground;
        };
        messages = {
          error = {
            bg = error;
            fg = inverted-foreground;
            border = error;
          };
          info = {
            bg = info;
            fg = inverted-foreground;
            border = info;
          };
          warning = {
            bg = warning;
            fg = inverted-foreground;
            border = warning;
          };
        };
        prompts = {
          bg = background;
          border = background;
          fg = foreground;
          selected.bg = secondary-background;
        };
        statusbar = {
          caret = {
            bg = selection-background;
            fg = foreground;
            selection = {
              bg = selection-background;
              fg = foreground;
            };
          };
          command = {
            bg = background;
            fg = foreground;
            private = {
              bg = secondary-background;
              fg = foreground;
            };
          };
          insert = {
            bg = info;
            fg = inverted-foreground;
          };
          normal = {
            bg = background;
            fg = foreground;
          };
          passthrough = {
            bg = info;
            fg = inverted-foreground;
          };
          private = {
            bg = secondary-background;
            fg = foreground;
          };
          progress.bg = info;
          url = {
            error.fg = error;
            fg = foreground;
            hover.fg = foreground;
            success = {
              http.fg = secondary-info;
              https.fg = info;
            };
            warn.fg = warning;
          };
        };
        tabs = {
          bar.bg = background;
          even = {
            bg = secondary-background;
            fg = foreground;
          };
          indicator = {
            inherit error;
            start = secondary-info;
            stop = info;
          };
          odd = {
            bg = background;
            fg = foreground;
          };
          pinned = {
            even = {
              bg = info;
              fg = inverted-foreground;
            };
            odd = {
              bg = secondary-info;
              fg = inverted-foreground;
            };
            selected = {
              even = {
                bg = selection-background;
                fg = foreground;
              };
              odd = {
                bg = selection-background;
                fg = foreground;
              };
            };
          };
          selected = {
            even = {
              bg = selection-background;
              fg = foreground;
            };
            odd = {
              bg = selection-background;
              fg = foreground;
            };
          };
        };
      };
    };
  };
}
