#!/bin/bash
# Run play

vault_argument=""

if [ $# -ge 1 ]; then
    vault_argument="--vault-password-file $1"
fi

run_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
cd "$run_path"
ansible-playbook \
    -l vor \
    -i ../../production.yml \
    ../../freyja.yml \
    $vault_argument
