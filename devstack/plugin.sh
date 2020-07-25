#!/bin/bash
#
# plugin.sh - DevStack plugin.sh dispatch script template
#
# See https://docs.openstack.org/devstack/latest/plugins.html for devstack plugin
#

#
# Usage:
# Adds the following lines to local.conf in devstack.
# ```
# enable_plugin horizon https://opendev.org/openstack/horizon.git stable/ussuri
# enable_plugin trove https://opendev.org/openstack/trove.git stable/ussuri
# enable_plugin trove-dashboard https://opendev.org/openstack/trove-dashboard stable/ussuri
# enable_plugin trove-dashboard-dev https://github.com/hiwakaba/trove-dashboard-dev stable/ussuri
# ```
# Then, run stack.sh!
#

# Save trace setting
XTRACE=$(set +o | grep xtrace)
set +o xtrace

# setenv
PATCH_DIR=$DEST/trove-dashboard-dev/devstack/patches

function preinstall_hook {
    # Downloads #738333 patches from review.opendev.org
    # destack will stop processing soon here in the pre-install phase if patches are not available.
    if [[ ! -f "${PATCH_DIR}/738333-patch.zip" ]]; then
        curl -L -o ${PATCH_DIR}/738333-patch.zip https://review.opendev.org/changes/738333/revisions/d371520529ea06669362ea0c1f47f1831f6be8b5/patch?zip
    fi
    if [[ -f "${PATCH_DIR}/738333-patch.zip" ]]; then
        unzip -d ${PATCH_DIR} ${PATCH_DIR}/738333-patch.zip
    else
        echo "[ERROR] 738333-patch.zip should exist, but not found"
        exit 1
    fi
    if [[ ! -f "${PATCH_DIR}/d371520.diff" ]]; then
        # come here if unzip fails
        echo "[ERROR] ${PATCH_DIR}/d371520.diff should exist, but not found"
        exit 1
    fi
}

function postconfig_hook {
    echo_summary "postconfig_hook"
    # Applies patches
    if [[ -f "${PATCH_DIR}/d371520.diff" ]]; then
        patch -p1 -d $DEST/trove-dashboard < ${PATCH_DIR}/d371520.diff 
        if [[ ${?} -eq 0 ]]; then
            echo "[ERROR] the command should exit with zero, but didn't: patch -p1 -d $DEST/trove-dashboard < ${PATCH_DIR}/d371520.diff"
            exit 1
        fi
    else
        echo "[ERROR] ${PATCH_DIR}/d371520.diff should exist, but not found"
        exit 1
    fi
}

# check for service enabled
if is_service_enabled trove-dashboard-dev ; then
    echo "[INFO] trove-dashboard-dev is enabled"

    if [[ "$1" == "stack" && "$2" == "pre-install" ]]; then
        # Downloads dashboard patches
        echo_summary "Checking if patches are available"
        preinstall_hook
    elif [[ "$1" == "stack" && "$2" == "post-config" ]]; then
        # Applies downloaded patches against trove-dashboard
        echo_summary "Applying patches against trove-dashboard"
        postconfig_hook
    fi

    if [[ "$1" == "unstack" ]]; then
        # Shut down template services
        # no-op
        :
    fi

    if [[ "$1" == "clean" ]]; then
        # Remove state and transient data
        # Remember clean.sh first calls unstack.sh
        # no-op
        :
    fi
else
    echo "[WARNING] trove-dashboard-dev is disabled"
fi

