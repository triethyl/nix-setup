{ config, lib, ... }: let
  cfg = config.aesthetics.targets.vesktop;
  aes = config.aesthetics;
in {
  options.aesthetics.targets.vesktop.enable = lib.mkOption {
    type = lib.types.bool;
    default = (aes.enableAllTargets && aes.hasGui);
    description = "Whether to enable the aesthetics vesktop target.";
  };
  config = lib.mkIf cfg.enable { 
    xdg.configFile."vesktop/themes/stylix.theme.css".text = with aes.scheme; ''
      :root {
        --base00: #${base00}; /* Black */
        --base01: #${base01}; /* Bright Black */
        --base02: #${base02}; /* Grey */
        --base03: #${base03}; /* Brighter Grey */
        --base04: #${base04}; /* Bright Grey */
        --base05: #${base05}; /* White */
        --base06: #${base06}; /* Brighter White */
        --base07: #${base07}; /* Bright White */
        --base08: #${base08}; /* Red */
        --base09: #${base09}; /* Orange */
        --base0A: #${base0A}; /* Yellow */
        --base0B: #${base0B}; /* Green */
        --base0C: #${base0C}; /* Cyan */
        --base0D: #${base0D}; /* Blue */
        --base0E: #${base0E}; /* Purple */
        --base0F: #${base0F}; /* Magenta */

        --primary-630: var(--base00); /* Autocomplete background */
        --primary-660: var(--base00); /* Search input background */
      }

      .theme-light, .theme-dark {
        --search-popout-option-fade: none; /* Disable fade for search popout */
        --bg-overlay-2: var(--base00); /* These 2 are needed for proper threads coloring */
        --home-background: var(--base00);
        --bg-overlay-chat : var(--base00); /* Recolor forum channels */
        --background-primary: var(--base00);
        --background-secondary: var(--base01);
        --background-secondary-alt: var(--base01);
        --channeltextarea-background: var(--base01);
        --background-tertiary: var(--base00);
        --background-accent: var(--base0E);
        --background-floating: var(--base01);
        --background-modifier-hover: #{{base00-hex}}4c; /* 30% of base00 */
        --background-modifier-selected: var(--base00);
        --text-normal: var(--base05);
        --text-secondary: var(--base03);
        --text-muted: var(--base04);
        --text-link: var(--base0C);
        --interactive-normal: var(--base05);
        --interactive-hover: var(--base05);
        --interactive-active: var(--base07);
        --interactive-muted: var(--base03);
        --channels-default: var(--base04);
        --channel-icon: var(--base04);
        --header-primary: var(--base06);
        --header-secondary: var(--base04);
        --scrollbar-thin-track: transparent;
        --scrollbar-auto-track: transparent;
      }
    '';
  };
}
