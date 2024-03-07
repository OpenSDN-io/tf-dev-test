#!/bin/bash

[[ "$DEBUG" == 'true' ]] && set -x

set -o errexit

# test options
export TF_TEST_NAME=${TF_TEST_NAME:-"smoke-test"}

# working environment
WORKSPACE=${WORKSPACE:-$(pwd)}
TF_CONFIG_DIR=${TF_CONFIG_DIR:-"${HOME}/.tf"}
TF_STACK_PROFILE="${TF_CONFIG_DIR}/stack.env"

# import tf profile that created by devstack into current context
set -o allexport
if [ -e "$TF_STACK_PROFILE" ] ; then
  cat "$TF_STACK_PROFILE"
  source "$TF_STACK_PROFILE"
fi
set +o allexport

# determined variables
export DISTRO=$(cat /etc/*release | egrep '^ID=' | awk -F= '{print $2}' | tr -d \")
PHYS_INT=`ip route get 1 | grep -o 'dev.*' | awk '{print($2)}'`
NODE_IP=`ip addr show dev $PHYS_INT | grep 'inet ' | awk '{print $2}' | head -n 1 | cut -d '/' -f 1`

# defaults for containers
export CONTAINER_REGISTRY=${CONTAINER_REGISTRY:-'opensdn'}
export CONTRAIL_CONTAINER_TAG=${CONTRAIL_CONTAINER_TAG:-'latest'}

# defaults stack
export ORCHESTRATOR=${ORCHESTRATOR:-"kubernetes"}
CONTROLLER_NODES="${CONTROLLER_NODES:-$NODE_IP}"
export CONTROLLER_NODES="$(echo $CONTROLLER_NODES | tr ',' ' ')"
AGENT_NODES="${AGENT_NODES:-$NODE_IP}"
export AGENT_NODES="$(echo $AGENT_NODES | tr ',' ' ')"
export SSL_ENABLE=${SSL_ENABLE:-false}

# Openstack defaults
export OPENSTACK_VERSION=${OPENSTACK_VERSION:-"queens"}

[[ "$DISTRO" != "rhel" ]] || export RHEL_VERSION="rhel$(cat /etc/redhat-release | egrep -o "[0-9]*\.[0-9]*" | sed 's/\.//')"
