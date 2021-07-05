# Flask Sample Application
This is a simple flask application to maintain a database of "offenders". This is a tongue in cheek database of all the things/peple that upset me and what I would have done to them come the glorious revolution.
It requires the data to be present in a MYSQl database.  Pass the vaiables listed below to connect to it.

I originally started developing the code using podman then developed this further so I could learn Openshift. As part of the excellent Redhat Partner training I decided to use this project as my demo of what I've learned so far.
Very much a work in progress.

# Diectories.
| Directory | Description |
| --------- | ----------- |
| flask-static-test | Contains initial python code as starting point |
| flask-with-mysql | Flask running locally using podman |
| flask-with-oshift | Code developed to run under Openshift |
| helm-blacklist | Helm chart for Openshift (Under development) |
| kustomize | Kustomize CICD (under development) |
| ocp3cmds | various OCP yaml files used for testing/developing the app |
| sql-scripts | Contains SQL statements used to populate database |
| static | Static code |
| templates | Openshift templating files |
| helm-blacklist-ephemeral | Helm template for ephemeral install |
| helm-blacklist-persistent | HELM template for persistent install |

# Files
| File | Description |
| ---- | ----------- |
| launch.bash | OCP script to run flask application |
| launch_mysql.bash | OCP script to launch mysql application |
| README.md | This file |

## Implementation Notes

This sample Python Flask application relies on the support provided by the default S2I builder for python apps.

* The entry point application code file needs to be named ``wsgi.py``.
* The following python modules must be listed in the ``requirements.txt``
```
ginicorn
PyMySQL
Flask
flask-sqlalchemy
SQLAlchemy<1.4
flask_bootstrap
flask_wtf
cryptography
```
NB Notice the SQLAlchemy line. This was a bug introduced March 15th where the new Library (1.5) doesn't work.

## Openshift Deployment Steps

To deploy this sample Python web application from the OpenShift web console, you should select ``python:3`` or ``python:latest``. 
The HTTPS URL of this code repository which should be supplied to the _Git Repository URL_ field when using _Add to project_ is:

* https://https://github.com/gary-crowe/hitlist#branch

If using the ```oc``` command line tool instead of the OpenShift web console, to deploy this sample Python web application, you can run:

```
oc new-app https://github.com/gary-crowe/hitlist#branch
  --name TheBlackList \
  -e MYSQL_HOST=mysql -e MYSQL_DATABASE=offenders -e MYSQL_USER=myuser -e MYSQL_PASSWORD=xxxx
```

In this case, because no language type was specified, OpenShift will determine the language by inspecting the code repository. Because the code repository contains a ``requirements.txt``, it will subsequently be interpreted as including a Python application. When such automatic detection is used, ``python:latest`` will be used.

If needing to select a specific Python version when using ```oc new-app```, you should instead use the form:

```
oc new-app python:3.6~https://github.com/gary-crowe/hitlist -e ...
```
## Compile the mysql container with:
```
podman build -t thelist:latest .
```
# Run pod with:
podman run -d -p 3306:3306  --name my-mysql -e MYSQL_ROOT_PASSWORD=XXXXX localhost/thelist:0.1

## If using the redhat image you need to pass a few more flags

podman run -d -p 3306:3306  --name my-mysql \
     -e MYSQL_USER=myuser -e MYSQL_PASSWORD=XXXX \
     -e MYSQL_DATABASE=offenders -e MYSQL_ROOT_PASSWORD=XXXX registry.redhat.io/rhscl/mysql-80-rhel7

podman exec -it my-mysql /opt/rh/rh-mysql80/root/usr/bin/mysql -ugary -pXXXX

https://medium.com/better-programming/customize-your-mysql-database-in-docker-723ffd59d8fb

#Build specifics
For the flask stuff & DB connectivity you will need to install the following in order to install the 
flask mysql library under pip:
```
yum install python3-devel
yum install mysql-devel
```

Now you can:
```
pip3 install flask-mysqldb
```
