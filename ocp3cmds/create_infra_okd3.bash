#!/bin/bash
# Create the infrastructure here. I am using the rather exceller "kcxli" utility for KVM.
#The commands to build the nodes using virt-manager:

#sudo virt-install --name=compute \
#--file=/var/lib/libvirt/images/infra.qcow2 --file-size=40 --graphics spice \
#--vcpus=2 --ram=8192 \
#--cdrom=/path/to/Downloads/CentOS-7-x86_64-Minimal-1810.iso \
#--network bridge=virbrN --os-type=linux --os-variant=centos7.0

kcli create vm -p centlarge -P ip=192.168.200.40 \
	-P netmask=255.255.255.0 -P gateway=192.168.200.1 \
	-P dns=192.168.200.1 oshiftmaster.okd.local

kcli create vm -p centsmall -P ip=192.168.200.50 \
	-P netmask=255.255.255.0 -P gateway=192.168.200.1 \
	-P dns=192.168.200.1 worker1.okd.local

kcli create vm -p centsmall -P ip=192.168.200.60 -P netmask=255.255.255.0 \
	-P gateway=192.168.200.1 -P dns=192.168.200.1 worker2.okd.local
