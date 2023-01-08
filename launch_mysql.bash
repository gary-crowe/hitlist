# Use this to pull direct if it's a public repo. http protocol
#oc new-app mysql:8.0~https://github.com/gary-crowe/hitlist \
#	--name mysql \
#	--source-secret repo-at-github \
#	--context-dir=flask-with-oshift \
#	--labels app.kubernetes.io/name=mysql-database,app.kubernetes.io/part-of=thehitlist \
#	--env MYSQL_DATABASE=offenders \
#	--env MYSQL_USER=gary \
#	--env MYSQL_PASSWORD=redhat123

# Use this if you have setup a private key and added as a secret.
oc new-app mysql:8.0~git@github.com:gary-crowe/hitlist.git \
	--name mysql  \
	--source-secret repo-at-github \
	--context-dir=flask-with-oshift \
	--labels app.kubernetes.io/name=mysql-database,app.kubernetes.io/part-of=thehitlist,app=mysql \
	--env MYSQL_DATABASE=offenders \
	--env MYSQL_USER=gary \
	--env MYSQL_PASSWORD=redhat123
