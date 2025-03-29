#!/bin/bash -e

my_file="$(readlink -e "$0")"
my_dir="$(dirname $my_file)"
source "$my_dir/../common/common.sh"
source "$my_dir/../common/functions.sh"

pushd $WORKSPACE

echo
echo "[$TF_TEST_NAME]"

# TODO: to be implemented

if [[ "$DEPLOYER" != 'rhosp' ]] ; then
  printf '%*s\n' 120 | tr ' ' '='
  sudo opensdn-status
  printf '%*s\n' 120 | tr ' ' '='
  if which docker >/dev/null 2>&1 ; then
    sudo docker ps -a
    printf '%*s\n' 120 | tr ' ' '='
    sudo docker images
  elif which ctr >/dev/null 2>&1 ; then
    sudo ctr -n k8s.io containers ls
    printf '%*s\n' 120 | tr ' ' '='
    sudo ctr -n k8s.io images ls
  fi
  printf '%*s\n' 120 | tr ' ' '*'
  ps ax -H
  printf '%*s\n' 120 | tr ' ' '*'
fi

if [[ "$ORCHESTRATOR" == "openstack" ]]; then
  ${my_dir}/test_openstack_vm.sh
fi

${my_dir}/test_webui.sh
