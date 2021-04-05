role-docker-server-traefik-proxy
================================

An Ansible role that is used to setup a single host docker server that makes use of `tecnativa/docker-socket-proxy` to prevent arbitrary access to Docker's socket, giving privelege escalation and possibilities for arbitrary code execution as root. It then installs Traefik to manage routing, certificate signing and proxying to all Docker containers, and will use the socket proxy to prevent a comprimised Traefik from being given able to escalate its priveleges to do bad things as root. And because this sets up a complete Docker server environment, it also will have a growing list of tasks to install specific containers with specific dictionary variables to set them up with all required configs.

Requirements
------------

Any pre-requisites that may not be covered by Ansible itself or the role should be mentioned here. For instance, if the role uses the EC2 module, it may be a good idea to mention in this section that the boto package is required.

Role Variables
--------------

- `gitea_enabled`: Defaults to false. Determines if gitea container will be setup.
- `git_group`: Defaults to `git`. The name for the git group the gitea container will use.
- `git_gid`: Defaults to omission. Sets the group id of the git user.
  - If omitted, then it will simply use the OS default for groups which typically involves finding the next availble ID from a range. In linux userspace IDs typically start at 1000, so after installing a main admin user on linux, that user is typically 1000, the next availble ID is then 1001.
- `git_user`: Defaults to `git`. The OS username that the gitea service will use.
- `git_uid`: Defaults to omission. Sets the User ID of the `git_user`.
  - Omission has the same effect as in `git_gid`.
- `git_passwd`: Required. Sets the password to switch to the `git_user`.
  - It's advisable to use an ansible vault to set this value or to inject it through `extra-vars` arguments.
- `git_home`: Defaults to `/home/git`. Sets the home directory of the `git_user`.
- `git_indexer_enable`: Defaults to `false`. Enables gitea's indexer feature, including setting up directories and configurations for it.

To-Do's
-------

- [ ] Add customization folders and configs, with enable vars
  - [ ] Should probably also include the `public` directory
- [ ] Preload SSH keys
- [ ] Fail2ban configuration, with enable vars and descriptions of the dependency

Dependencies
------------

A list of other roles hosted on Galaxy should go here, plus any details in regards to parameters that may need to be set for other roles, or variables that are used from other roles.

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    - hosts: servers
      roles:
         - { role: username.rolename, x: 42 }

License
-------

BSD

Author Information
------------------

An optional section for the role authors to include contact information, or a website (HTML is not allowed).
