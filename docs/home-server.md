# Home Server

## Programs:

Categories:

- core: Uncontainerized services like ssh, backups, and caddy.
- cloud: File storage services like syncthing.
- development: Developer operations services like gitolite and cgit.
- gaming: Game servers like minecraft.
- media: Media services like calibre-web, invidious, and plex.
- networking: Networking services like Wireguard, firewall, etc.
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

### Directory Layout

/srv/
  www/: Personal website.
  sync/: Syncronized files.
  git/: Repos and data for Gitolite and Cgit.
  minecraft/: Minecraft servers.

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
