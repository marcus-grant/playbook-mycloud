To-Do's
=======

In-Progress
-----------

- [ ] NTP role

Planning
--------

- [ ] Add prompt & arg for specifying path to vault key so you don't have to share its path
- [ ] Some role or tasks to manage images for each host
- [ ] Docker: Portainer
- [ ] Docker: Nextcloud
- [ ] Docker: UniFi-Controller
- [ ] Docker: Gitea
- [ ] Start splitting docker containers by inventory groups
    - Nextcloud & Gitea should be on freyr
    - AWX / Semaphore / ARA on thor
- [ ] Replacement for Plex (emby?)
- [ ] Docker: Traefik
- [ ] Extra play installing docker on workstations (archlinux family using pacman)
    - geerlinguyr's docker role doesn't work on archlinux family
    - the archlinux workstations will have do docker slightly different as well
    - make sure you're using overlay2 or whatever the current hotness is

Future
------

- [ ] Docker: Code-Server or MS's solution
- [ ] Docker: Home-Assistant
- [ ] Docker: CouchPotato
- [ ] Docker: Sonarr
- [ ] Docker: Radarr
- [ ] Docker: Jackett
- [ ] Docker: NZBGet
- [ ] Docker: Bitwarden
- [ ] Docker: Calibre Server
- [ ] Docker: Diskover
- [ ] Docker: COPS
- [ ] Docker: TIG Stack
- [ ] Docker: Mastodon
- [ ] NFS server role
- [ ] Geerlingguy's pip role which allows ansible-building of docker images from ansible
- [ ] First kubernetes plays
- [ ] Docker: beets
- [ ] Docker: grocy
- [ ] Docker: thelounge

Completed
---------

- [x] Become different users like root & marcus for dotfiles role
- [x] Try geerlingguy's docker role
- [x] Apply common packages role (after editing to work on debian)
- [x] Apply dotfiles role with server-only dotfiles