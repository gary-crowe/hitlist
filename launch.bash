oc new-app http://bastion2.zbd.local:3000/gary/TheBlackList.git --context-dir=flask-with-oshift --name theblacklist \
-e MYSQL_HOST=mysql \
-e MYSQL_DATABASE=offenders \
-e MYSQL_USER=gary \
-e MYSQL_PASSWORD=redhat123
