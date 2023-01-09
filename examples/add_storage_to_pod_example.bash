 oc set volumes deployment/theblacklist \
  --add --name extra-storage --type pvc \
  --claim-mode rwo --claim-size 10Gi --mount-path /var/lib/pgsql \
  --claim-name extra-storage
