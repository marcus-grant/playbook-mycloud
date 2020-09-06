# Runner for new plays based on a group identifier where it only
# runs a single play file for only that group.
# Used to develop plays.

# Exports
export ANSIBLE_NOCOW=false
# export PYTHONUNBUFFERED=1
# export ANSIBLE_FORCE_COLOR=true
# solution to man in the middle ssh warnings on host PC
# solution comes from this ansible issue: http://bit.ly/2HyLvQg
# TODO remove if no longer a problem.
# export ANSIBLE_HOST_KEY_CHECKING=False
# export ANSIBLE_STDOUT_CALLBACK=yaml
# ANSIBLE_SSH_ARGS='-o UserKnownHostsFile=/dev/null -o ControlMaster=auto -o ControlPersist=60s'
# ANSIBLE_STDOUT_CALLBACK=debug
RUN_PATH=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
PROJECT_PATH="$(dirname $(dirname $RUN_PATH))"
LIMIT_GROUP=freyja

# To obscure where keyfiles are stored,
# ... prompt for them, then set them to an exported variable that can be
# ... referenced in future runs.
# NOTE this is only useful if there isn't already an ansible.cfg with
# ... the vault keyfile setting defined
# if [[ -z "$_ANSIBLE_VAULT_KEYFILE" ]]; then
#     msg="No keyfile path in _ANSIBLE_VAULT_KEYFILE, where is the keyfile?: "
#     _TMP_FILE=""
#     while [ ! -f "$_TMP_FILE" ]; do
#         read -p "$msg" _TMP_FILE
#     done
#     export _ANSIBLE_VAULT_KEYFILE="$_TMP_FILE"
# fi
ansible-playbook                    \
    -i $PROJECT_PATH/production.yml  \
    -l $LIMIT_GROUP                 \
    $PROJECT_PATH/kungsten.yml
    # if you must use this for ssh keys, ideally use ssh config
    # --private-key=$_PRIVATE_KEY     \
