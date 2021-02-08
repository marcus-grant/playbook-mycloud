# Ansible DevOps Notes

## Miscellaneous

### Install From Requirements File

```bash
ansible-galaxy role install -f -r requirements.yml
```

- `role` specifies install of roles vs `collection`
- `install` to install a given role by string or...
- `-r` to install from a requirements file
- `-f` to force reinstall or install newer version

#### requirements.yml

```yaml
---
- name: name-or-org.role-name
  src: https://gitrepository.org/name/role-name
  version: branch-or-tag
- name: ansible-galaxy-username.role-name
```

- Here you can see two kinds of role definitions:
  - Single key `name` where you can simply stick to the role name preceeded by the publisher of the role on [ansible-galaxy](https://galaxy.ansible.com/)
- If the role isn't published on ansible galaxy you can pull them from a git repository instead using:
  - `name` key to give it a name you reference in a play
  - `src` key to point to the address of the repository
    - Could be github, gitlab, or a self hosted server
  - `version` key specifies which branch or tag to pull from

### Good practice pre task for any play

```yaml
# ...
  pre_tasks:
    - name: Update apt cache
      apt:
        update_cache: true
        cache_valid_time: 600
      when: ansible_os_family == 'Debian'
# ...
```

## Sensible VPS Initial Setup on Debian/Ubuntu

### Start with Seperate Init Play to Setup SSH & Admin User

SSH is the main way to administer and sometimes even tunneling connections into a remote virtual server. Hardening it then becomes crucially important for the security of whatever is put into it, including sensitive data.

Because this will involve first connecting to the server with default settings, often with a provided SSH key, an initial play will need to be run which will set new SSH settings and users for future ansible connections to make. Trying to do all of this in a single play is a massive pain, so better to seperate this out into a separate `init.yml` play.

#### Update the Vault Encrypted Inventory

```bash
ansible-vault edit inventory.yml
```

This will edit your encrypted inventory. A good idea because some very sensitive information like privelege escelation passwords and public facing URLs will be put here. Edit it to with the desired ansible group, hosts and their respective info like below.

```yaml
---
all:
  children:
    cloud: # a group named 'cloud'
      hosts:
        srv1: # a host named 'srv1'
          ansible_host: example.com
          ansible_port: 12345 # any unused port number 10,000~65,535
          ansible_user: someone
          ansible_become_password: secure-password
          ansible_ssh_private_keyfile: ~/.ssh/id_rsa
```

Some notes about each line:

- `all`: is the root of an inventory file.
- `children`: specifies all child groups in an inventory.
- `cloud`: is a inventory group named 'cloud' in this case, it could be named anything.
- `hosts`: is a necessary key to define hosts within an inventory group.
- `srv1`: is a named host, in this case 'srv1', and can be named anything.
- `ansible_host`: the URL or IP address used to connect to the host.
- `ansible_port`: the SSH port used to connect to the host, should use a non standard port.
  - Nonstandard ports are useful because bots will blast public facing servers with brute force attempts to login to the SSH server, non standard ports cuts down on successful connection attempts.
  - Few standard ports exist in above port 10000.
  - Port numbers are a 16 bit unsigned integer, so the last port possible is 65535
- `ansible-become-password`: the password the new user will use to gain root privelege.
  - This should be the password to be assigned to the new users' sudo access.
- `ansible_ssh_private_keyfile`: the SSH private key file to use to connect to the host.

With this information entered into the inventory file, the play can be written with variable substitution to fill in all the relevant information to initialize the server. Now create that play file, calling it `init.yml` in the root of the playbook directory.

```yaml
---
- hosts: all
  user: root
  tasks:
    - name: Create main admin user
      user:
        name: '{{ main_admin_user }}'
        password: '{{ ansible_become_password | password_hash("sha512", main_admin_user) }}'
        groups: [sudo]
        state: present
        shell: /bin/bash
        createhome: true
```

This creates a play that should apply to any host this gets used with thanks to the `all` group specifier. Because this needs to be done with the `root` user that gets specified below it as well. As usual in a play, there needs to be a list of tasks or roles to be run, here we'll just define the tasks explicitly as a list within the `tasks` YAML key.

The first task to be done is a bit complex but will in one task do these things: create the user defined in the inventory file, hash & salt the inventory defined password for that user, add it to the `sudo` group, set it to use the `bash` shell, and give it a home directory. A little about each step will be explained in the next few paragraphs, jump to the next section if it is self explanatory. Probably, the password hashing is worth reading about however.

The `password_hash` ansible filter takes the password defined in `ansible_become_password` and sends it to the `pasasword_hash` filter. This is important because passwords get stored in a hashed form in linux which is good because it obscures what they are if intercepted somehow. It does increase the complexity of defining the password of a new user in ansible. The `password_hash` filter takes in its first argument the hash algorithm, `sha_512` in this case, and a 0-16 character which will just be the username. Without getting into complex cryptography, it's just a way to make a hash unique but still compatible with the initial value being hashed. This is a good security measure to deal with [rainbow table][rainbow] attacks.

The `groups` key in the `user` module of this task just adds the current user to a list of groups. In ansbile's YAML format, it's possible to define lists in one line. If there were two or more groups those could be added to the user as well by seperating them with commas within the square brackets like this: `[sudo, admin, chads]`. This user is added to the `sudo` group because a later task will allow it to escalate user priveleges through the `sudo` command.

The rest of the parameters are fairly explanatory. The `state` parameter just determines how to handle this state of the user, with `present` telling it that it should just be modified if there's changes to be made. The `shell` parameter allows setting the startup shell that user will use when logged in, in this case `bash`. And finally `createhome` makes sure that a home directory for this user exists, with default location `/home/USERNAME`.

### Give New User Sudo Priveleges

It's generally adivisable when setting up servers like this, especially with heavy automation, that most of the root access happens with a priveleged non-root account. This means there's no need to connect to root directly through SSH and programs like `sudo` and linux's permissions system can be customized to restrict how root permissions are given out.

The next task is to change the [sudoers][sudoers] file. This is the file that `sudo` uses to verify the access rights of different users, groups, and how those permissions are granted. For this task, it's easy enough to just enable the `sudo` group access when a password is given.

```yaml
# ./init.yml
  # ...
  tasks:
  # ...
    - name: 'Allow "sudo" group to sudo'
      lineinfile:
        path: /etc/sudoers
        state: present
        regexp: '^%sudo'
        line: '%sudo	ALL=(ALL:ALL) ALL'
        validate: '/usr/sbin/visudo -cf %s'
```

The `lineinfile` [module][lineinfile] gets used here to change the pre-existing `/etc/sudoers` that Debian provides. The Ubuntu one is compatible to this task as well.

The `regexp` parameter is a [regular expression][regexp] that identifies the line to be replaced. Here the `%sudo` part indicates, with the `%`, that a group name is to be given priveleged permissions.

The `line` parameter then defines the line in the file to replace it with. In this case it gives `ALL` permissions of root, and the last `ALL` means all privelege escalations apply. This mostly means entering root permissions requires using the user password.

Then finally, and this is important for a sudoers file, a validation command is run to ensure that the changes are readable by the `sudo` program. This is done by running the sudo editting program `visudo` and passing it the `-cf` parameter which is used to imply only validation is needed, and the `%s` is there for ansible to pass along the file path.

### Setup Fail2Ban

A big step up in securing a server's remote connections is to install and configure [fail2ban][fail2ban]. This is an intrusion prevention tool that periodically scans linux logs for failed attempts to make a connection. When a specified number of failures happen within a time span it will then modify the firewall to block those addresses failing to authenticate, effectively banning them. This prevents attackers from brute forcing passwords and encryption keys long before they try enough permutations for a chance to connect.

First things first, `fail2ban` needs to be installed, so let's add a task that does so using the `apt` ansible module.

```yaml
# ./init.yml
# ...
  tasks:
  # ...
    - name: Install fail2ban
      apt:
        name: fail2ban
        state: latest
```

Next is configuring fail2ban under what conditions it will ban failed connection attempts. This is important to get right, because make it too strict and you may find yourself locked out of your own server.

Linuxize has a great [guide][howtofail2ban] on how to customize Fail2ban further than will be done here. The file location being used in this next step is going to be in `/etc/fail2ban/jail.local`. Let's write that next ansible text.

```yaml
# ./init.yml
# ...
  tasks:
  # ...
    - name: Copy over the local fail2ban configuration
      copy:
        src: ./files/fail2ban/jail.local
        dest: /etc/fail2ban/jail.local
        owner: root
        group: root
        mode: 0644
```

Here the builtin [copy][copy] ansible module is used to copy over local file in this playbook shown below over to the remote server. The `src` parameter points to the file to copy over shown below in this playbook over to the remote server specified with `dest`. The `owner` and `group` defines the user and group ownership as `root`. Then it sets the read/write/execute permissions as `0644` in the `mode` parameter. Meaning it can be read and written by the owner user, and only read by everyone else. Next, write

## References

- [The Weltraumschaf: Hardening Your SSHd with Ansible][harden-ssh-ansible]
[harden-ssh-ansible]: https://blog.weltraumschaf.de/blog/Hardening-Your-SSHd-with-Ansible/ "The Weltraumschaf: Hardening Your SSHd with Ansible"
- [StackOverflow: Setting Password for Linux Users in Ansible with Hash][ansible-user-hash]
[ansible-user-hash]: https://stackoverflow.com/a/50110960 "StackOverflow: Setting Password for Linux Users in Ansible with Hash"
- [Wikipedia: Rainbow Table][rainbow]
[rainbow]: https://en.wikipedia.org/wiki/Rainbow_table "Wikipedia: Rainbow Table"
- [Ubuntu Wiki: Sudoers][sudoers]
[sudoers]: https://help.ubuntu.com/community/Sudoers "Ubuntu Wiki: Sudoers"
- [Ansible Documentation: lineinfile Module][lineinfile]
[lineinfile]: https://docs.ansible.com/ansible/latest/collections/ansible/builtin/lineinfile_module.html "Ansible Documentation: lineinfile Module"
- [Wikipedia: Regular Expression][regexp]
[regexp]: https://en.wikipedia.org/wiki/Regular_expression "Wikipedia: Regular Expression"
- [Fail2Ban: Main Page][fail2ban]
[fail2ban]: https://www.fail2ban.org/wiki/index.php/Main_Page "Fail2Ban: Main Page"
- [Github: Jeff Geerling][geerlingguy]
[geerlingguy]: https://github.com/geerlingguy "Github: Jeff Geerling"
- [Linuxize: How to Install & Configure Fail2ban on Ubuntu][howtofail2ban]
[howtofail2ban]: https://linuxize.com/post/install-configure-fail2ban-on-ubuntu-20-04/ "Linuxize: How to Install & Configure Fail2ban on Ubuntu"
- [Ansible Documentation: Copy Module][copy]
[copy]: https://docs.ansible.com/ansible/latest/collections/ansible/builtin/copy_module.html "Ansible Documentation: Copy Module"