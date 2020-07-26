# trove-dashboard-dev

Here is an easy way to setup devstack with trove-dashboard for development on your PC by using Vagrant.

## Usage with Vagrant

Run the following commands on your PC.
```
$ git clone https://github.com/hiwakaba/trove-dashboard-dev --branch stable/ussuri
$ cd trove-dashboard-dev
$ vagrant plugin install vagrant-disksize
$ vagrant up
$ vagrant ssh -c "sudo su - stack sh -c './setup.sh'"
```
Then, open http://http://192.168.33.30/dashboard/project/databases/launch, then you will see the list of flavors!
