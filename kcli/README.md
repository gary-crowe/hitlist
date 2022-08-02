# Notes on kcli
I use kcli at home to quickly spin up clusters.  Here are some notes.

## Spin up cluster from command line
```yaml
kcli create kube generic -P masters=1 \
         -P workers=2 -P pool=ha -P network=General \
         -P api_ip=192.168.200.90 -P domain=zbd.local
```
# From parameter file
```yaml
kcli create kube generic --paramfile=k8.yml
export KUBECONFIG=$HOME/.kcli/clusters/gc-test/auth/kubeconfig
```

## Useful blog
https://linuxera.org/capabilities-seccomp-kubernetes/

### Create a cluster with metallb
```yaml
kcli create kube generic -P masters=1 -P workers=1  -P master_memory=4096 \
-P numcpus=2 -P worker_memory=4096 -P sdn=calico -P version=1.24 \
-P ingress=true -P ingress_method=nginx -P metallb=true -P engine=crio \
-P domain=zbd.local caps-cluster
```

