role-docker-server-traefik-proxy
================================

An Ansible role that is used to setup a single host docker server that makes use of `tecnativa/docker-socket-proxy` to prevent arbitrary access to Docker's socket, giving privelege escalation and possibilities for arbitrary code execution as root. It then installs Traefik to manage routing, certificate signing and proxying to all Docker containers, and will use the socket proxy to prevent a comprimised Traefik from being given able to escalate its priveleges to do bad things as root. And because this sets up a complete Docker server environment, it also will have a growing list of tasks to install specific containers with specific dictionary variables to set them up with all required configs.

Requirements
------------

Any pre-requisites that may not be covered by Ansible itself or the role should be mentioned here. For instance, if the role uses the EC2 module, it may be a good idea to mention in this section that the boto package is required.

Role Variables
--------------

A description of the settable variables for this role should go here, including any variables that are in defaults/main.yml, vars/main.yml, and any variables that can/should be set via parameters to the role. Any variables that are read from other roles and/or the global scope (ie. hostvars, group vars, etc.) should be mentioned here as well.

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
