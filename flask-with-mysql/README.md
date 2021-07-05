# Flask app: offenders
This is a fork of the static flash example. This follows on from the static demo I did. Here we use a mysql remote DB. The idea is to get it working under Openshift/K8's as a useful demo.

## Instructions.
1. Make sure your SQL database is up and running.  I'm using podman:
```
podman run -d -p 3306:3306  --name my-mysql \
     -e MYSQL_USER=myuser -e MYSQL_PASSWORD=XXXX \
     -e MYSQL_DATABASE=offenders -e MYSQL_ROOT_PASSWORD=XXXX registry.redhat.io/rhscl/mysql-80-rhel7
```
2. For the time being, populate the database using the SQL scripts. You will need to allow some time after the creation of the pod before you populate. I don't know why that is. Possibly my hardware???
```
podman exec -it my-mysql /opt/rh/rh-mysql80/root/usr/bin/mysql -h localhost -P 3306 --protocol=tcp \
       -u myuser -pXXXX < sqlscripts/CreateTable.sql
```
3. Set the following enviromental values. You can set them manually:
```
DATABASE_URL=<FQDN> or <IP address>
DATABASE_NAME=$MYSQL_DATABASE
USERNAME=$MYSQL_USER
PASSWORD=$MYSQL_PASSWORD
```
alternatively, edit the setup.bash script and source that:
```source setup.bash```

4. test you can connect to the database:
```
python testconmysql.py
```

5. Fireup the applicaton:
```
python offenders.py &
```
5. Launch a local browser and point it at socket 5000 on 'localhost'

### Adding data.
Navigate to  your flask running application:  ```http://localhost:5000/add_record```
The image you specify should be approx 200x200px and placed in the static/images directory for now. I plan to put those images into a seperate mongodb microservice.  I grabbed images from `Tinternet and used imagemagik to convert to a suitable size:

```
identify -format "%wx%h" image.jpg
convert image.jpg -resize 200x200 > image.jpg
```
Currently a work in progress as I am still learning how to do all of this.
G.Crowe 6/1/2020
