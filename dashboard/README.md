# Contains information on accessing kubernetes dashboard
See: https://github.com/kubernetes/dashboard/blob/master/docs/user/access-control/creating-sample-user.md

1. Run the yaml file located in this directory.
```yaml
kubectl create -f svc-accnt.yml
```
2. Generate your token:
```yaml
kubectl -n kubernetes-dashboard create token admin-user
```
