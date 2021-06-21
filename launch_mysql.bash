oc new-app mysql:8.0~http://bastion2.zbd.local:3000/gary/TheBlackList#clean \
	--name mysql \
	--context-dir=flask-with-oshift \
	--env MYSQL_OPERATIONS_USER=opuser \
	--env MYSQL_OPERATIONS_PASSWORD=oppass \
	--env MYSQL_DATABASE=offenders \
	--env MYSQL_USER=gary \
	--env MYSQL_PASSWORD=redhat123
