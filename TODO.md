To-Do's
=======

In-Progress
-----------

- [ ] Docker: Nextcloud & Its database
- [ ] Docker: Gitea

Planning
--------

- [ ] Add ansible_ssh_user to docker group
- [ ] Some role or tasks to manage docker images for each host
- [ ] Make sure aptitude gets installed on all debian servers before any other task
- [ ] Add yourself or some other user as part of the docker group
- [ ] Refactor the `become`'s in playbook and associated tasks
    - even though the geerlingguy.docker role already does this, but make sure it's done before
- [ ] Refactor roles & tasks to show less skipped outputs depending on OS & host
    - this [tip](http://bit.ly/2HGIZaV) might help
- [ ] Add prompt & arg for specifying path to vault key so you don't have to share its path
- [ ] Create testing provisioning/inventory that starts multiple representative VMs
- [ ] Start splitting docker containers by inventory groups
    - Nextcloud & Gitea should be on freyr
- [ ] Docker: Traefik

Future
------

- [ ] Replacement for Plex (emby?)
- [ ] Extra play installing docker on workstations (archlinux family using pacman)
    - geerlinguyr's docker role doesn't work on archlinux family
    - the archlinux workstations will have do docker slightly different as well
    - make sure you're using overlay2 or whatever the current hotness is
- [ ] Automate a swap space, swappiness and memory limits of docker
- [ ] Split the nextcloud app and db containers between tasks to be used on different servers
- [ ] Docker: AWX / Semaphore / ARA on thor
- [ ] Docker: Code-Server or MS's solution
- [ ] Docker: Refactor docker_server_env task
- [ ] Docker: Home-Assistant
- [ ] Docker: Vault (Hashicorp)
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
- [ ] Docker: thelounge
- [ ] Docker: grocy
- [ ] Docker: Watchtower
- [ ] Docker: Couchpotato
- [ ] Docker: Heimdal
- [ ] Docker: consider changing the nextcloud image to `fpm` tag and proxy traefik to it

Completed
---------

- [x] Docker: UniFi-Controller
- [x] Docker: Portainer
- [x] Task to bootstrap docker environment (docker_home)
- [x] Make sure pip is installed then the python docker module so ansible can easily manage docker
- [x] NTP role
- [x] Become different users like root & marcus for dotfiles role
- [x] Try geerlingguy's docker role
- [x] Apply common packages role (after editing to work on debian)
- [x] Apply dotfiles role with server-only dotfiles