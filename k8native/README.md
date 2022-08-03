# Instructions to implement this code.
This has been tested on my home k8's cluster that was built using the excellent kcli tool.
Used as a learning exercise to muck about with kubernetes, kustomize and various k8's features.

## Install using kustomize
Install kustomize onto your target development machine: https://kubernetes.io/docs/tasks/manage-kubernetes-objects/kustomization/
This will assume that you have a storage class of "nfs" for the PVC. Edit pvc.yml to suit your build.

1. Create the hitlist namespace
2. ```kustomize build . | kubectl create -f - ```
#
# Installing manually (far more fun)
1. Create the hitlist namespace
```yaml
kubectl create namespace hitlist
```
2. Create the nfs storage class
```yaml
kubectl apply -f sc.yml
```
3. Edit the NFS PV's already created in the cluster so they are storage type "nfs"
```yaml
Name:            pv001
Annotations:     pv.kubernetes.io/bound-by-controller: yes
StorageClass:    nfs
Status:          Bound
Claim:           hitlist/mysql-pvc
Reclaim Policy:  Recycle
Access Modes:    RWO
VolumeMode:      Filesystem
Capacity:        30Gi
Node Affinity:   <none>
Source:
    Type:      NFS (an NFS mount that lasts the lifetime of a pod)
    Server:    192.168.122.167
    Path:      /pv001
    ReadOnly:  false
```
4. Create the PV claim
```yaml
kubectl create -f pvc-nfs.yml
```
5. Create the secret
```yaml
kubectl create -f secret.yml
```
6. Create the ConfigMap that gets mounted as a disk with DB initialisation commands
```yaml
kubectl create -f configmap.yml
```
7. Create the mysql deployment
```yaml
kubectl create -f mysql-deploy.yml
```
8. Create the Service for mysql
```yaml
kubectl create -f svc-mysql.yml
```
9. Create the flask service (load-balancer via metallb on kcli)
```yaml
kubectl get svc -n hitlist
NAME        TYPE           CLUSTER-IP     EXTERNAL-IP       PORT(S)        AGE
mysql       ClusterIP      10.97.15.121   <none>            3306/TCP       16h
svc-flask   LoadBalancer   10.105.32.43   192.168.122.242   80:31432/TCP   16h

kubectl get ep -n hitlist
NAME        ENDPOINTS          AGE
mysql       10.244.1.13:3306   16h
svc-flask   10.244.2.12:5000   16h
```
 And that's it. Point your browser at the External IP.
#

#
## General notes
https://stackoverflow.com/questions/45681780/how-to-initialize-mysql-container-when-created-on-kubernetes
```bash
kubectl create secret generic mysql-secret --from-literal=mysql-root-password=kube1234 
    --from-literal=mysql-user=testadm --from-literal=mysql-password=kube1234
```
```bash
kubectl create configmap db --from-literal=mysql-database: database
```
# Populate database
```bash
kubectl exec -i mysql-856b4ff659-7cw9n -- mysql -uroot -predhat123 offenders < sql-scripts/CreateTable.sql
```
# Comand line args:
```yaml
kubectl create deployment hello-world --image=quay.io/gary_crowe/flask
kubectl expose deployment/hello-world --type=NodePort --port=80 --name=hello-world-service --target-port=5000
```
# Populate mysql database from file:
```yaml
kubectl exec -i <mysql-pod> -n hitlist -- mysql -uroot -pXXXXXXX offenders < sql-scripts/Populate.sql
```
