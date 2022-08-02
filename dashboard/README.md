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
eyJhbGciOiJSUzI1NiIsImtpZCI6IjZmbTc3NnR1MGZxckdKS2ZZVEdVVHd3OVA5N1NFSjFhX0pFUjJieFo5cU0ifQ.eyJhdWQiOlsiaHR0cHM6Ly9rdWJlcm5ldGVzLmRlZmF1bHQuc3ZjLmNsdXN0ZXIubG9jYWwiXSwiZXhwIjoxNjU5NDU3Mjc3LCJpYXQiOjE2NTk0NTM2NzcsImlzcyI6Imh0dHBzOi8va3ViZXJuZXRlcy5kZWZhdWx0LnN2Yy5jbHVzdGVyLmxvY2FsIiwia3ViZXJuZXRlcy5pbyI6eyJuYW1lc3BhY2UiOiJrdWJlcm5ldGVzLWRhc2hib2FyZCIsInNlcnZpY2VhY2NvdW50Ijp7Im5hbWUiOiJhZG1pbi11c2VyIiwidWlkIjoiMTA4MWNhN2QtYmE3NC00YTFlLTg5OGUtODIzMzhhMjg0YmNmIn19LCJuYmYiOjE2NTk0NTM2NzcsInN1YiI6InN5c3RlbTpzZXJ2aWNlYWNjb3VudDprdWJlcm5ldGVzLWRhc2hib2FyZDphZG1pbi11c2VyIn0.VZ4mqA-qOsXYLVq8mDWnhIXttMJ4fC9Rr_jK7fLJn0D48-ISLr5AbtdzYfwbMMJ2sxtou1f8uDAtX6ux0G97fF8wQlUVBeGZNuXr3dq-mCEm7ILnLfoQMMMWnzamZis6uKRTTG4U5H_awwKS5y5exHC8BZDMjo4ZpKEoFmytGNdDp9h1tm-LVySyxapVTjCCNAk6t-Bw6If3y5wjWseeOUvZZodpWaWytBU0-4gJuMm_X9pvvhJq1nkCD_myTpN6Fw5y5zTns5I789ptWlFtqpM2xc6Q5AejqaCDrNbRgH2QSRNRmqJl7_Mir0esMHq_NTiVhxo5FG_ur6AodXebag