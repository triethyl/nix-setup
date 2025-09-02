# Aesthetics

My crappy custom nix module for managing:

- Base16 colors
- Window opacity
- System font
- Wallpapers

## Structure

- default.nix: Creates all main options to be set by modules in the themes dir. also configures the font and enables one theme.
- themes/: Contains modules with sets of base16 colors and which set options in default.nix. These modules can contain direct configs for certain apps if the apps have poor base16 support, but they must obey the options set in the app's target module.
- targets/: Contains modules configuring apps using base16 colors or just setting options to enable or disable the theming of an app.

