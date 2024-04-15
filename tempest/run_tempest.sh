#!/bin/bash
set -o errexit

my_file="$(readlink -e "$0")"
my_dir="$(dirname $my_file)"

if [ -f ~/overcloudrc ] ; then
  source ~/overcloudrc
fi

source "$my_dir/../common/openrc"

TEST_SUBNET_CIDR="${TEST_SUBNET_CIDR:-172.23.0.0/24}"

sudo apt-get update -y;
sudo apt-get install python3-virtualenv -y;
mkdir -p venvs;
virtualenv -v -p python3 --clear --download ./venvs/openstack
source ./venvs/openstack/bin/activate
pip3 install openstackclient
pip3 install Jinja2
export OS_PASSWORD=$AUTH_PASSWORD
openstack network create --share --external tf-tempest-test
openstack subnet create --allocation-pool 'start=172.23.0.10,end=172.23.0.15' --dhcp --subnet-range "$TEST_SUBNET_CIDR" --network tf-tempest-test tf-tempest-subnet-test
export PUBLIC_NETWORK_ID=$(openstack network show tf-tempest-test -f value -c id)
TEMPEST_TEMPLATE=${TEMPEST_TEMPLATE:-"$my_dir/tempest.conf.j2"}
echo "INFO: prepare input parameters from template $TEMPEST_TEMPLATE"
"$my_dir/../common/jinja2_render.py" < $TEMPEST_TEMPLATE > tempest.conf
git clone https://github.com/openstack/tempest.git
cd tempest/; pip install .
cd ..
tempest init cloud-01
cp ./tempest.conf cloud-01/etc/
cp $my_dir/blacklist cloud-01/etc/
env
cd cloud-01
set +e
tempest run -r tempest.api.network --serial --exclude-list etc/blacklist
res=$(echo $?)
echo "INFO: collect logs"
if [ -e tempest.log ]; then
      tar -cvf $WORKSPACE/logs.tar tempest.log
      cd ../reports
      tar -rvf $WORKSPACE/logs.tar *
      popd
      gzip $WORKSPACE/logs.tar
      mv $WORKSPACE/logs.tar.gz $WORKSPACE/logs.tgz
else
    echo "WARNING: folder tempest.log not found"
    ls -l
fi

exit $res