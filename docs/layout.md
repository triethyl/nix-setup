# Layout

I have no idea why codeberg shows this without any newlines.

features/: Simple reusable configurations (only create an enable option and maybe one other).
  system/
    gui/: Graphical configurations.
      desktops/: Desktop environments, compositors, window managers, etc.
      apps/: Graphical apps.
      bundles/: Collections of gui configurations.
    cli/: Commandline configurations.
      scripts/: Custom scripts.
      apps/: Commandline apps (TUIs).
      utils/: Commandline utils.
      shells/: Shell configurations.
      bundles/: Collections of cli configs.
    services/: Service configurations.
      core/: Highest importance services.
      extra/: Medium importance services.
      misc/: Miscellaneous services.
      hardware/: Hardware services.
      bundles: Collections of service configs.
    global/: Always enabled on every device.
    server/: Server configurations.
      core/: Core server configs (e.g. SSH, Backups, system monitoring).
      media/: Server apps for managing media (books, videos, etc) (e.g. Calibre or Invidious).
      cloud/: Server apps for file storage (e.g. Syncthing, Nextcloud).
      development/: Server apps to assist in development (e.g. Git server setup).
      gaming/: Game servers (e.g. Minecraft).
  user/
    gui/: Graphical configurations.
      desktops/
      apps/
      bundles/
    cli/
      scripts/
      apps/
      utils/
      bundles/
    services/
    global/
      home-manager.nix
modules/: Custom nix modules (Can create any amount of options).
  system/: Custom nixos modules.
  user/: Custom home-manager modules.
    aesthetics/
      default.nix
      targets/
      themes/
secrets/: Age-encrypted secrets integrated with nixos.
  user-passwords/
    culsans.age
    lucas.age
    server.age
users/: User specific home manager configurations
  nzxt-desktop/
    culsans.nix
  ideapad-laptop/
    lucas.nix
  prodesk-server/
    server.nix
  pendrive-iso/
    pendrive.nix
systems/: System-specific nixos configurations.
  nzxt-desktop/
    system.nix
    hardware.nix
  ideapad-laptop/
    system.nix
    hardware.nix
  prodesk-server/
    system.nix
    hardware.nix
  pendrive-iso/
    system.nix
    hardware.nix
