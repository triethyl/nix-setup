[back](../readme.md)

# Home Server

## Programs:

Categories:

- core: Uncontainerized services like ssh, backups, and caddy.
- cloud: File storage services like syncthing.
- dev: Developer operations services like gitolite and cgit.
- game: Game servers like minecraft.
- media: Media services like calibre-web, invidious, and plex.
- network: Networking services like Wireguard, firewall, etc.
### Services

#### Uncontainerized:

- SSH
- Backups
- Caddy

#### Containerized:

- Git Server (Gitolite, Cgit)
- Calibre
- Invidious
- Syncthing
- Minecraft
- Wireguard

#### Considering:

- Plex
- File Storage?

### Module Layout

- homelab/
    - default.nix
    - core/
    - cloud/
    - dev/
    - game/
    - media/
    - network/

### Data Layout

- /srv/
    - www/: Personal website.
    - sync/: Syncronized files.
    - git/: Repos and data for Gitolite and Cgit.
    - minecraft/: Minecraft servers.

### Checklist

- [ ] Setup SSH
- [ ] Setup Syncthing
- [ ] Setup Caddy
- [ ] Setup Https Website
- [ ] Setup Minecraft Server
- [ ] Setup Git Server
- [ ] Setup Wireguard
- [ ] Setup Invidious
- [ ] Setup Calibre
