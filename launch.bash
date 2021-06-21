oc new-app https://github.com/gary-crowe/hitlist \
	--context-dir=flask-with-oshift \
	--name theblacklist \
	-e MYSQL_HOST=mysql \
	-e MYSQL_DATABASE=offenders \
	-e MYSQL_USER=gary \
	-e MYSQL_PASSWORD=redhat123
