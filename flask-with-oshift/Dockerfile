# Using official python runtime base image
#FROM image-registry.openshift-image-registry.svc:5000/openshift/python:latest
FROM registry.access.redhat.com/ubi8/python-39:1

# Install our requirements.txt
USER root

COPY requirements.txt /opt/app-root/src
WORKDIR /opt/app-root/src

RUN pip3 install --upgrade pip \
  && pip3 install -r requirements.txt

# Copy our code from the current folder to /app inside the container
USER 1001
ADD . /opt/app-root/src

# Make port 5000 available for links and/or publish
EXPOSE 5000

# Define our command to be run when launching the container
#CMD gunicorn --bind 0.0.0.0:5000 wsgi.py
gunicorn --bind 127.0.0.1:5000 wsgi:app
