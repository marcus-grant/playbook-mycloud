To-Do's
=======

In-Progress
-----------

- [ ] Extra play installing docker on workstations (archlinux family using pacman)
    - geerlinguyr's docker role doesn't work on archlinux family
    - the archlinux workstations will have do docker slightly different as well
    - make sure you're using overlay2 or whatever the current hotness is
- [ ] Try geerlingguy's docker role
- [ ] Become different users like root & marcus for dotfiles role
- [ ] NTP role

Planning
--------

- [ ] Some role or tasks to manage images for each host
- [ ] Docker: Portainer
- [ ] Docker: Nextcloud
- [ ] Docker: Gitea
- [ ] Docker: Traefik
- [ ] Start splitting docker containers by inventory groups
    - Nextcloud & Gitea should be on freyr
- [ ] Docker: Home-Assistant
- [ ] Docker: Calibre Server
- [ ] Docker: TIG Stack

Future
------

- [ ] NFS server role
- [ ] Geerlingguy's pip role which allows ansible-building of docker images from ansible

Completed
---------

- [x] Apply common packages role (after editing to work on debian)
- [x] Apply dotfiles role with server-only dotfiles