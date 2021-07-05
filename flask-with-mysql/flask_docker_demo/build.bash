podman build --layers --force-rm --tag flask .
podman run -dt --name flask localhost/flask
