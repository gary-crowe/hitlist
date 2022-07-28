# General notes
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

