#!/bin/bash -e

my_file="$(readlink -e "$0")"
my_dir="$(dirname $my_file)"
source "$my_dir/../common/common.sh"
source "$my_dir/../common/functions.sh"

pushd $WORKSPACE

echo "[$TF_TEST_NAME]"

# TODO: to be implemented

if [[ "$ORCHESTRATOR" == "openstack" ]]; then
  ${my_dir}/run_tempest.sh
fi
