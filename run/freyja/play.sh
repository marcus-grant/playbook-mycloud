#!/bin/bash
# First a helper function that finds the directory of this script
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

# Playbook & run dir locations
scriptDir="$(get-script-dir)"
projectDir="$(dirname $(dirname $scriptDir))"

# Check that the secrets file is available, fail if not
if [ ! -e $projectDir/group_vars/secrets.yml ]; then
    echo "ERROR: The secrets file isn't present so this play can't be run"
    exit 1
fi

# Some ansible and python vars for optimization and preference
export PYTHONUNBUFFERED=1
export ANSIBLE_FORCE_COLOR=true
# ANSIBLE_HOST_KEY_CHECKING=false
# export ANSIBLE_SSH_ARGS='-o UserKnownHostsFile=/dev/null \ 
# -o ControlMaster=auto -o ControlPersist=60s'
# export ANSIBLE_STDOUT_CALLBACK=debug
export ANSIBLE_NOCOW=1
export ANSIBLE_STDOUT_CALLBACK=yaml

# Playbook arguments
secretVars="$scriptDir/group_vars/secrets"
