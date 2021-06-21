#!/bin/bash
# Creates the Database Pod and populates. Removes any existing pod with same name.
countdown()
(
  IFS=:
  set -- $*
  secs=$(( ${1#0} * 3600 + ${2#0} * 60 + ${3#0} ))
  while [ $secs -gt 0 ]
  do
    sleep 1 &
    printf "\r%02d:%02d:%02d" $((secs/3600)) $(( (secs/60)%60)) $((secs%60))
    secs=$(( $secs - 1 ))
    wait
  done
  echo
)

podman rm -f gary-mysql 2>/dev/null
podman run -d -p 3306:3306  --name gary-mysql \
     -e MYSQL_USER=gary \
     -e MYSQL_PASSWORD=redhat123 \
     -e MYSQL_DATABASE=offenders \
     -e MYSQL_ROOT_PASSWORD=redhat123 \
      registry.redhat.io/rhscl/mysql-80-rhel7

echo "Waiting 60 seconds for pod to initialise"
countdown "00:01:00" # 10 sec
echo populating
podman exec -i gary-mysql /opt/rh/rh-mysql80/root/usr/bin/mysql -h localhost -P 3306 --protocol=tcp -ugary -predhat123 offenders < sqlscripts/CreateTable.sql
