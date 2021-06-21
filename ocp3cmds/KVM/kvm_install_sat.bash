#!/bin/bash
# Creates a rhel7 machine under KVM. Use the terraform code
# in preference unless you want the satellite server to have lvm partitioning

# Uses kickstart file:rhel.cfg edit this for IP addresses etc.

NAME="Satellite68"
DESC="Satellite 6.8" \
RAM=32768
CPUS=4

# Change to your pool ID.
cd /ssd
qemu-img create -f qcow2 -o preallocation=metadata sat68_root.qcow2 80G
qemu-img create -f qcow2 -o preallocation=metadata sat68_pulp.qcow2 120G

cd -
virt-install -n ${NAME} --description "${DESC}" \
  --os-type=Linux  \
  --os-variant=rhel7.9 --ram=${RAM} --vcpus=${CPUS} \
  --disk path=/ssd/sat68_root.qcow2,bus=virtio,format=qcow2 \
  --disk path=/ssd/sat68_pulp.qcow2,bus=virtio,format=qcow2 \
  --network network:sat-net,model=virtio \
  --nographics \
  --cpu host-model-only \
  --location=/iso/rhel-server-7.9-x86_64-dvd.iso \
  --initrd-inject=."/rhel.cfg" \
  --extra-args "ks=file:/rhel.cfg console=tty0 console=ttyS0,115200n8"
