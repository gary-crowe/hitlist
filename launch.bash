# Use this to pull from public repo using https:
oc new-app https://github.com/gary-crowe/hitlist \
	--context-dir=flask-with-oshift \
	--labels app.kubernetes.io/name=python,app.kubernetes.io/part-of=thehitlist \
	--name theblacklist \
	-e MYSQL_HOST=mysql \
	-e MYSQL_DATABASE=offenders \
	-e MYSQL_USER=gary \
	-e MYSQL_PASSWORD=redhat123

# NB. If you launch this from a differtnt namespace, target the actual namesapce like this:
# -e MYSQL_HOST=mysql.blacklist

# Use this is you have created a private key and secret
#See: create_github_secret.bash in this folder

#oc new-app python~git@github.com:gary-crowe/hitlist.git \
#	--context-dir=flask-with-oshift \
#	--source-secret repo-at-github \
#	--name theblacklist \
#	--labels app.kubernetes.io/name=python,app.kubernetes.io/part-of=thehitlist \
#	-e MYSQL_HOST=mysql \
#	-e MYSQL_DATABASE=offenders \
#	-e MYSQL_USER=gary \
#	-e MYSQL_PASSWORD=redhat123
