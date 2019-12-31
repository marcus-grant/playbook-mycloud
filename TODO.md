To-Do's
=======

In-Progress
-----------

- [ ] Create run script for frigg
- [ ] Add libvirt/kvm packages to be installed on frigg
- [ ] Nextcloud: Deploy to frigg
- [ ] Swap space configuration for cloud hosts
- [ ] Replacement for Plex (emby?, jellyfin?)
- [ ] Traefik: home deployment

Planning
--------

- [ ] Docker: Gitea
- [ ] Best combination of services for:
-   - [ ] Personal music streaming
-   - [ ] External streaming service aggregation
-   - [ ] Podcasts
- [ ] Make sure aptitude gets installed on all debian servers before any other task
- [ ] Nextcloud: Configure for S3 primary storage
- [ ] Refactor: homeservers to nyc, wpb, etc?
- [ ] s3fs FUSE mount for primary nextcloud store
- [ ] Add yourself or some other user as part of the docker group
- [ ] Test: Make selectable vagrant definition for ocean group machine
- [ ] Refactor the `become`'s in playbook and associated tasks
    - even though the geerlingguy.docker role already does this, but make sure it's done before
- [ ] Refactor roles & tasks to show less skipped outputs depending on OS & host
    - this [tip](http://bit.ly/2HGIZaV) might help
- [ ] Create testing provisioning/inventory that starts multiple representative VMs
- [ ] TICK stack on nyc for testing out use cases
- [ ] Start splitting docker containers by inventory groups
    - Nextcloud & Gitea should be on freyr
- [ ] Zswap role

Future
------

- [ ] Some role or tasks to manage docker images for each host
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

- [x] Traefik: v2 with tested deployment on ocean
- [x] Docker: Traefik
- [x] UFW tasks to open up 80 & 443 (HTTP & HTTPS) ports
- [x] Test: Make ocean grouped test vms have domain names that can be accessed
- [x] Add prompt & args for run script for actual system that hides keys
- [x] Encrypted inventory `production.yml`
- [x] Digital Ocean inventory definitions & group vars
- [x] Move nextcloud to ocean group
- [x] Run scripts, for ocean
- [x] Add ansible_ssh_user to docker group
- [x] Docker: Nextcloud & Its database
- [x] Docker: UniFi-Controller
- [x] Docker: Portainer
- [x] Task to bootstrap docker environment (docker_home)
- [x] Make sure pip is installed then the python docker module so ansible can easily manage docker
- [x] NTP role
- [x] Become different users like root & marcus for dotfiles role
- [x] Try geerlingguy's docker role
- [x] Apply common packages role (after editing to work on debian)
- [x] Apply dotfiles role with server-only dotfiles
