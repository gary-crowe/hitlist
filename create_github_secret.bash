#! /bin/bash
# https://cookbook.openshift.org/building-and-deploying-from-source/how-can-i-build-from-a-private-repository-on-github.html

# Create your secret and import into the project as a deployment key
ssh-keygen -C "openshift-source-builder/repo@github" -f repo-at-github -N ''
# Create the secret from the id_rsa private file
oc create secret generic repo-at-github \
	 --from-file=ssh-privatekey=/home/gary/.ssh/id_rsa --type=kubernetes.io/ssh-auth
# Link to builder
oc secrets link builder repo-at-github
# Now run the launch scripts
