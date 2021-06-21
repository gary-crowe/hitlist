oc new-app mysql:8.0~https://github.com/gary-crowe/hitlist \
	--name mysql \
	--context-dir=flask-with-oshift \
	--env MYSQL_DATABASE=offenders \
	--env MYSQL_USER=gary \
	--env MYSQL_PASSWORD=redhat123
