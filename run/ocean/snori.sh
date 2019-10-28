# Run play

run_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
cd "$run_path"
ansible-playbook \
    -l snori \
    -i ../../production.yml \
    ../../playbook.yml
