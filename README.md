# Flask Sample Application
This is a simple flask application to maintain a database of "offenders". This is a tongue in cheek database ofr all the things/peple that upset me and what I would have done to them come the glorious revolution.
It requires the data to be present in a MYSQl database.  Pass the vaiables listed below to connect to it.

Used as a teaching aid for myself in how to add developed code from podman into Openshift & playing around with VSC & Docker desktop.  Loving the container experience!

## Running
It requires gunicorn to run the webserver from Openshift/K8s.  Invoke using the main python file wsgi.py in these environments.

The database should already exist and have the following schema:
```
CREATE TABLE gits (
position TINYINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
offender varchar(40),
wiki varchar(100),
crime varchar(500),
punishment varchar(200),
image varchar(200),
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```
I'm working on a template to pre-populate. 

## Implementation Notes

This sample Python application relies on the support provided by the default S2I builder for python apps.

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
NB Notice the SQLAlchemy line. This was a bug introduced March 15th wher ethe new Library (1.5) doesn't work.

## Openshift Deployment Steps

To deploy this sample Python web application from the OpenShift web console, you should select ``python:3`` or ``python:latest``. 
The HTTPS URL of this code repository which should be supplied to the _Git Repository URL_ field when using _Add to project_ is:

* https://https://github.com/gary-crowe/hitlist#branch

If using the ``oc`` command line tool instead of the OpenShift web console, to deploy this sample Python web application, you can run:

```
oc new-app https://github.com/gary-crowe/hitlist#branch
  --name TheBlackList \
  -e MYSQL_HOST=mysql -e MYSQL_DATABASE=offenders -e MYSQL_USER=gary -e MYSQL_PASSWORD=xxxx
```

In this case, because no language type was specified, OpenShift will determine the language by inspecting the code repository. Because the code repository contains a ``requirements.txt``, it will subsequently be interpreted as including a Python application. When such automatic detection is used, ``python:latest`` will be used.

If needing to select a specific Python version when using ``oc new-app``, you should instead use the form:

```
oc new-app python:3.6~https://github.com/gary-crowe/hitlist -e ...
```
