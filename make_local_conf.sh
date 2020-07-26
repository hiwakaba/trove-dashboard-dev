#!/bin/bash

#
# make devstack/local.conf
#

#
# Usage:
# $ ./make_local_conf.sh
#
LOCALCONF_FILE=devstack/local.conf

cat > ${LOCALCONF_FILE} <<EOF
[[local|localrc]]
RECLONE=True
HOST_IP=10.0.2.15
IP_VERSION=4

enable_plugin horizon https://opendev.org/openstack/horizon.git stable/ussuri
enable_plugin trove https://opendev.org/openstack/trove.git stable/ussuri
enable_plugin trove-dashboard https://opendev.org/openstack/trove-dashboard stable/ussuri
enable_plugin trove-dashboard-dev https://github.com/hiwakaba/trove-dashboard-dev stable/ussuri

LIBS_FROM_GIT+=,python-troveclient
DATABASE_PASSWORD=password
ADMIN_PASSWORD=password
SERVICE_PASSWORD=password
SERVICE_TOKEN=password
RABBIT_PASSWORD=password
LOGFILE=\$DEST/logs/stack.sh.log
VERBOSE=True
LOG_COLOR=False
LOGDAYS=1

# Pre-requisites
ENABLED_SERVICES=rabbit,mysql,key

# Horizon
enable_service horizon

# Nova
enable_service n-api
enable_service n-cpu
enable_service n-cond
enable_service n-sch
enable_service n-api-meta
enable_service placement-api
enable_service placement-client

# Glance
enable_service g-api
enable_service g-reg

# Cinder
enable_service cinder
enable_service c-api
enable_service c-vol
enable_service c-sch

# Neutron
enable_service q-svc
enable_service q-agt
enable_service q-dhcp
enable_service q-l3
enable_service q-meta

# Swift
ENABLED_SERVICES+=,swift
SWIFT_HASH=66a3d6b56c1f479c8b4e70ab5c2000f5
SWIFT_REPLICAS=1
SWIFT_DATA_DIR=\$DEST/data
# Swift default 5G
SWIFT_MAX_FILE_SIZE=5368709122
# Swift disk size 10G
SWIFT_LOOPBACK_DISK_SIZE=10G

# TROVE
TROVE_ENABLE_IMAGE_BUILD=True

# Python3
USE_PYTHON3=True
PYTHON3_VERSION=3.6

EOF
