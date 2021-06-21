oc create -f - <<EOF
apiVersion: v1
kind: PersistentVolume
metadata:
  name: registry
spec:
  capacity:
    storage: 100Gi
  accessModes:
  - ReadWriteOnce
  nfs:
    path: /export/reg
    server: nfs4.ocp4.local
  persistentVolumeReclaimPolicy: Retain
  storageClassName: non-dynamic
EOF
oc create -f - <<EOF
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  finalizers:
  - kubernetes.io/pvc-protection
  name: image-registry-storage
  namespace: openshift-image-registry
spec:
  accessModes:
  - ReadWriteMany
  resources:
    requests:
      storage: 100Gi
EOF
