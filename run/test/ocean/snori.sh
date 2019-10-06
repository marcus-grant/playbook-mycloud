# look here for info: https://docs.ansible.com/ansible/latest/scenario_guides/guide_vagrant.html
# ansible-playbook --private-key=~/.vagrant.d/insecure_private_key -u vagrant -i .vagrant
get-script-dir(){
    source="${BASH_SOURCE[0]}"
    while [ -h "$source" ]; do # resolve $source until the file is no longer a symlink
      dir="$( cd -P "$( dirname "$source" )" && pwd )"
      source="$(readlink "$source")"
      # if $source was a relative symlink, we need to resolve it relative
      # to the path where the symlink file was located
      [[ $source != /* ]] && source="$dir/$source"
    done
    echo "$( cd -P "$( dirname "$source" )" && pwd )"
}

# Script Args
scriptDir="$(get-script-dir)"
projectDir="$(dirname $(dirname $(dirname $scriptDir)))"
pBook="$projectDir/playbook.yml"
# invent="$projectDir/.vagrant/provisioners/ansible/inventory/vagrant_ansible_inventory"
# invent="$projectDir/hosts.yml"
invent="$projectDir/testing.yml"
privateKey="$projectDir/.vagrant/machines/default/virtualbox/private_key"
pBookUser="vagrant"

# Ansible env vars for running its commands
export PYTHONUNBUFFERED=1
export ANSIBLE_FORCE_COLOR=true
ANSIBLE_HOST_KEY_CHECKING=false
ANSIBLE_SSH_ARGS='-o UserKnownHostsFile=/dev/null -o ControlMaster=auto -o ControlPersist=60s'
ANSIBLE_STDOUT_CALLBACK=debug
export ANSIBLE_NOCOW=1
export ANSIBLE_STDOUT_CALLBACK=yaml
# solution to man in the middle ssh warnings on host PC
# solution comes from this ansible issue: http://bit.ly/2HyLvQg
export ANSIBLE_HOST_KEY_CHECKING=False

# Debug message before running play
echo "Running playbook.yml for vagrant instance..."
echo "============================================"
echo "(projectDir: $projectDir)"
echo "(inventory: ${invent#${projectDir}/})"
echo "(playbook: ${pBook#${projectDir}/})"
echo "(ssh-key: ${privateKey#${projectDir}/})"

# Run play
ansible-playbook \
    --private-key=$privateKey \
    -u $pBookUser \
    -i $invent \
    -l snori \
    $pBook
