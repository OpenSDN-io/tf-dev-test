# tf-dev-test

tf-dev-test is a tool for testing of Tungsten Fabric deployments by means of various test suites and methods.

Supported test suites are:
- [smoke](https://github.com/opensdn-io/tf-dev-test/tree/master/smoke-test)
- [tf-sanity](https://github.com/opensdn-io/tf-dev-test/tree/master/tf-sanity)
- [deployment-test](https://github.com/opensdn-io/tf-dev-test/tree/master/deployment-test)

Generic interface consists of the following environment variables:
- ORCHESTRATOR      - deployment orchestrator: kubernetes (default) or openstack
- OPENSTACK_VERSION - version of OpenStack (default is queens, it is for OpenStack deployments only)
- CONTROLLER_NODES  - list of TF Controller nodes (default is the current node - AIO installation)
                      delimited with space or comma
- AGENT_NODES       - list of TF Agent Controller nodes (default is the current node - AIO installation)
                      delimited with space or comma
- DOMAINSUFFIX      - domain name suffix (by default is detected from the current host)

There might be additional parameters depending on a test.

The project is seemlessly integrated with [tf-devstack](https://github.com/opensdn-io/tf-devstack/tree/master). So that there is no need to provide parameters as they be consumed automatically.

Example for AIO installation with tf-devstack:

```bash
git clone https://github.com/opensdn-io/tf-dev-test
git clone https://github.com/opensdn-io/tf-devstack
./tf-devstack/ansible/run.sh
./tf-dev-test/smoke-test/run.sh
```
