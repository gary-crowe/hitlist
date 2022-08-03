podman build --layers --force-rm --tag flask:latest .
podman run -d --name flask -p 5000:5000 flask:latest
