# Flask Sample Application

This repository provides a sample Python web application implemented using the Flask web framework
It requires gunicorn to run the webserver so that must be included in your requirements.txt.  Also your main python file must be called wsgi.py
Used as a teaching aid for myself in how to add developed code from podman into Openshift.

## Implementation Notes

This sample Python application relies on the support provided by the default S2I builder for python apps.

* The entry point application code file needs to be named ```wsgi.py``.
* The following python modules must be listed in the ``requirements.txt``
```
ginicorn
PyMySQL
Flask
flask-sqlalchemy
flask_bootstrap
flask_wtf
cryptography
```
## Deployment Steps

To deploy this sample Python web application from the OpenShift web console, you should select ``python:3`` or ``python:latest``. 
The HTTPS URL of this code repository which should be supplied to the _Git Repository URL_ field when using _Add to project_ is:

* https://github.com/gary_crowe/openshift-flask#branch

If using the ``oc`` command line tool instead of the OpenShift web console, to deploy this sample Python web application, you can run:

```
oc new-app https://github.com/gary_crowe/openshift-flask#branch \
  --name myflask \
  -e MYSQL_HOST=mysql -e MYSQL_DATABASE=offenders -e MYSQL_USER=myuser -e MYSQL_PASSWORD=XXXXX
```

In this case, because no language type was specified, OpenShift will determine the language by inspecting the code repository. Because the code repository contains a ``requirements.txt``, it will subsequently be interpreted as including a Python application. When such automatic detection is used, ``python:latest`` will be used.

If needing to select a specific Python version when using ``oc new-app``, you should instead use the form:

```
oc new-app python:3.6~https://github.com/gary_crowe/openshift-flask -e ...
```
