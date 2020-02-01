# Run play

export ANSIBLE_NOCOWS=false
run_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
cd "$run_path"
ansible-playbook \
    -l frigg \
    -i ../../production.yml \
    ../../dev.yml
