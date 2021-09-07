To-Do's
=======

In-Progress
-----------

- [ ] Add `cryptsetup` to pkgs on debian servers like freyja
- [ ] Create a central borgbackup repo server on freyja
    - like [here](https://borgbackup.readthedocs.io/en/stable/deployment/central-backup-server.html)
- [ ] Merge this & workstation playbooks into one new repo
- [ ] Move all todos to issues, starting with higher priority
- [ ] YAMLLint & AnsibleLint entire mycloud+myworkstation project
- [ ] Try kubespray or rancher to setup home k8s cluster
- [ ] Let's encrypt egress (pod or bare?)
- [ ] Docker: Gitea
- [ ] Nginx reverse proxy pod
- [ ] DynDNS daemon
- [ ] Nextcloud: Deploy cluster or freyja
- [ ] Encrypted FUSE mounts (things like gitea data)
- [ ] NFS role (look for premade stuff) (both client & server)
- [ ] Replacement for Plex (emby?, jellyfin?)
- [ ] Add git clone installer task content
    - make sure to add task var for binary paths from cloned repo
- [ ] Traefik: home deployment
    - http://bit.ly/2QGpliG might help
- [ ] Change `kungsten` hosts in `production.yml` to FQDNs
- [ ] Best combination of services for:
  - [ ] Personal music streaming
  - [ ] External streaming service aggregation
  - [ ] Podcasts
- [ ] Docker: Pomoday
- [ ] Docker: Web Things
- [ ] Docker: Home-Assistant
- [ ] Docker: Mastodon
- [ ] Plan way to manage ansible clients' `/etc/ansible/hosts` file using ansible instead of passing around `production.yml` in a vault
- [ ] Docker: PiHole
- [ ] Docker: Huginn
- [ ] Docker: [n8n](http://bit.ly/37uf14l) automater and event agent like huginn

Planning
--------

- [ ] Checkout taskbook
- [ ] Make sure aptitude gets installed on all debian servers before any other task
- [ ] Swap space configuration for cloud hosts
- [ ] [Ciao](http://bit.ly/37v7Cl4) web endpoint monitor/alerts
- [ ] Postgres Database on bare metal
- [ ] SSH Logins Alerts on Telegram
    - Also consider pushbullet or twilio api
- [ ] Refactor: add play groups like `ocean` `nyc-kube`, etc.
- - [ ] Nextcloud: Configure for S3 primary storage
- [ ] Refactor: homeservers to nyc, wpb, etc?
- [ ] s3fs FUSE mount for primary nextcloud store
- [ ] Checkout [Timeliner](http://bit.ly/2tpYnE0)
- [ ] Funkwhale or one of the air/sub sonics for music serving
- [ ] Checkout [Lemmy](http://bit.ly/36gYpgf)
- [ ] Checkout [PyShelf](http://bit.ly/2MM8r1e)
- [ ] Add firewalld_default_zone to firewalld if not present in `tasks/firewalld.yml`
- [ ] Add yourself or some other user as part of the docker group
- [ ] Test: Make selectable vagrant definition for ocean group machine
- [ ] Jenkins on thor
- [ ] TICK stack on nyc for testing out use cases
- [ ] Refactor the `become`'s in playbook and associated tasks
    - even though the geerlingguy.docker role already does this, but make sure it's done before
- [ ] Refactor roles & tasks to show less skipped outputs depending on OS & host
    - this [tip](http://bit.ly/2HGIZaV) might help
- [ ] Create testing provisioning/inventory that starts multiple representative VMs
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
- [ ] Docker: Vault (Hashicorp)
- [ ] Read [this](http://bit.ly/35hFG2T) before doing any of the content servers
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

- [x] Install UniFi container on frigg
- [?] Get podman running on frigg works in basic cases but rootless permissions issues (abandoning for now after settings fedora to cgroupsv1)
- [x] Refactor: split out `playbook` into plays
- [x] Create run script for frigg
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
- [x] Get some basic runners working
- [x] Make playbook & inventory group for `kungsten`
