podman build --layers --force-rm --tag flask:latest .
podman run -d --name flask -p 5001:5001 flask:latest
