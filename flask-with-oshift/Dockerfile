# Using official python runtime base image
FROM image-registry.openshift-image-registry.svc:5000/openshift/python:latest

# Install our requirements.txt
ADD requirements.txt /opt/app-root/src/requirements.txt
RUN pip install -r requirements.txt

# Copy our code from the current folder to /app inside the container
ADD . /opt/app-root/src

# Make port 80 available for links and/or publish
EXPOSE 5000

# Define our command to be run when launching the container
CMD [ "python", "wsgi.py" ]
