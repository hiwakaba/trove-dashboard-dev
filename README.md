# trove-dashboard-dev

## Usage

Adds the following lines to local.conf in devstack, then run stack.sh!
```
enable_plugin horizon https://opendev.org/openstack/horizon.git stable/ussuri
enable_plugin trove https://opendev.org/openstack/trove.git stable/ussuri
enable_plugin trove-dashboard https://opendev.org/openstack/trove-dashboard stable/ussuri
enable_plugin trove-dashboard-dev https://github.com/hiwakaba/trove-dashboard-dev stable/ussuri
```

