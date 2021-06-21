kcli create vm -p rh78large -P ip=192.168.200.10 -P netmask=255.255.255.0 -P gateway=192.168.200.1 -P dns=192.168.200.1 oshiftmaster.ocp3.local
kcli create vm -p rh78small -P ip=192.168.200.20 -P netmask=255.255.255.0 -P gateway=192.168.200.1 -P dns=192.168.200.1 worker1.ocp3.local
kcli create vm -p rh78small -P ip=192.168.200.30 -P netmask=255.255.255.0 -P gateway=192.168.200.1 -P dns=192.168.200.1 worker2.ocp3.local
