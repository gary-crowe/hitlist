# Installing a helm chart
See: https://docs.openshift.com/container-platform/4.13/applications/working_with_helm_charts/installing-helm.html
1.	First install helm
```bash
sudo curl -L https://mirror.openshift.com/pub/openshift-v4/clients/helm/latest/helm-linux-amd64 -o /usr/local/bin/helm
```
2. Make binary executable
```bash
 chmod +x /usr/local/bin/helm
```
3. helm install <NAME> /path/to/chart	
```bash
helm install  mylemchart /home/gary/helm/mychart/
```

