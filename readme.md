Welcome to my Nix* setup!

Iteration: 7?

This repo contains multi-device configurations for nixos and home-manager, including features like agenix for secret management, a wrapped neovim package with mnw, and more.

> [!WARNING]
> I am an amateur at nix and programming in general, please assume that this code is inefficient and unprofessional.

> [!CAUTION]
> The following documents are likely outdated and do not reflect the actual state of this repo.

- [Todo List](./docs/todo.md)
- [Directory Organization](./docs/layout.md)
- [Home Server Setup](./docs/home-server.md)

## Features

- agenix secret management
- custom desktop setup with the niri compositor
- custom (bad) base16 theme system
- flake boilerplate shortener library
- automatic nix file imports
- multiple users per device
- very organized

## Devices

- nzxt-desktop: My custom-built desktop pc in an nzxt case (not actually made by nzxt).
- ideapad-laptop: My cheap lenovo ideapad I use for schoolwork.
- prodesk-server: My home server running on an hp prodesk desktop.
- steam-deck: My steam deck running nixos with jovian-nixos.

## Credits

- [The flake boilerplate shortener library](lib/helper.nix) was partially stolen from Vimjoyer, though I have heavily stripped it down and modified it (and probably made it worse).
- [The nix file auto-importation code](lib/umport.nix) was taken from the ylib library and slightly modified to not import flake.nix and shell.nix files.
- Everyone who worked on the stuff in my flake inputs, thanks for the great software!
