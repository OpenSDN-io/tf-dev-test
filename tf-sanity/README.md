# TF sanity test for a TF deployment

It runs the corresponding to the orchestrator test suit from [tf-test](https://github.com/opensdn-io/tf-test/tree/master) project.

# Environment parameters

ORCHESTRATOR - can be one of 'openstack', 'kubernetes', 'hybrid'

CONTROLLER_NODES - it’s a list of comma separated IP-s of control plane (tf, openstack, kubernetes). for now tf-dev-test support only configurations where all components of control plane (tf, openstack, kubernetes) are placed one same machines (for example "IP1,IP2,IP3")

AGENT_NODES - it’s a list of comma separated IP-s of agent nodes (compute, kubernetes worker). Same comment is here - there is no possibility to specify different nodes for computes and kubernetes.

SSH_USER - user to access remote nodes (current user by default)

CONTAINER_REGISTRY - registry of images in cluster (opensdn, or your private registry)

CONTRAIL_CONTAINER_TAG - tag of images in cluster (latest, master-latest, ...)

TF_TEST_IMAGE - full id of tf-test image if it's not equal to CONTAINER_REGISTRY, CONTRAIL_CONTAINER_TAG (registry, name, tag)

TF_TEST_TARGET - one or several comma separated targets like ci_sanity, ci_k8s_sanity, ci_openshift(openshift 3.x)

SSL_ENABLE - just true or false. Is SSL enabled in the deployment or not

SSL_KEY, SSL_CERT, SSL_CACERT - paths to certs/keys

DEPLOYER - how the setup was deployed. with ansible-deployer, helm-deployer, juju, rhosp, k8s_manifests, openshift

OPENSTACK_VERSION - queens, rocky, stein, train, …

AUTH_PASSWORD, AUTH_DOMAIN, AUTH_REGION, AUTH_URL, AUTH_PORT - keystone params if present

DOMAINSUFFIX - domain of deployment (useful in helm)

TF_DEPLOYMENT_TEST_IMAGE - full id of deployment-test image is it's not equal to CONTAINER_REGISTRY, CONTRAIL_CONTAINER_TAG (registry, name, tag)
