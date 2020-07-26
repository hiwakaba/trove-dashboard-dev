#!/bin/bash

#
# Clone devstack and run stack.sh
#

#
# Usage:
# $ ./setup_devstack.sh
#

if [[ "${USER}" != "stack" ]]; then
    echo "[ERROR] This script should be run by 'stack' user, but now run by ${USER}"
    exit 1
fi
STACK_USER=$(whoami)

DEVSTACK_DIR=devstack
if [[ -d "${DEVSTACK_DIR}" ]]; then
    echo "[ERROR] ${DEVSTACK_DIR} should not exist. Delete ${DEVSTACK_DIR} directory before running this script"
    exit 1
fi

git clone https://git.openstack.org/openstack-dev/devstack --branch stable/ussuri

LOCALCONF_FILE=${DEVSTACK_DIR}/local.conf
if [[ -f "${LOCALCONF_FILE}" ]]; then
    echo "[ERROR] ${LOCALCONF_FILE} should not exist. Delete ${LOCALCONF_FILE} before running this script"
    exit 1
else
    ./make_local_conf.sh
fi

cd devstack
./stack.sh

