# Instructions to implement this code.
This code contains k8's manifests to create the hitlist app and use service mesh for reporting/proxy etc.
Used as a learning exercise to muck about with istio

## Extract the Istio ingress gateway URL
```bash
oc get route istio-ingressgateway -n istio-system \
-o template --template '{{ "http://" }}{{ .spec.host }}'
```

## Grab the kialli URL
```bash
oc get route kiali -n istio-system \
-o template --template '{{ "https://" }}{{ .spec.host }}'
```

## Add your namespace to service mesh
```bash
oc patch servicemeshmemberroll/default -n istio-system --type=merge -p '{"spec": {"members": ["hitlist"]}}'
```
or manually edit:
```bash
oc -n istio-system edit smmr
```
## Verify if the service mesh control plane pods are running and the status of installation:
```bash
oc -n<control_plane_project> get pods
oc -n<control_plane_project> get smcp

oc get smcp -n istio-system
NAME    READY   STATUS            PROFILES      VERSION   AGE
basic   9/9     ComponentsReady   ["default"]   2.3.1     96m
```
## Remember your deployment must have the sidecar annotation to work.  Check with:
```bash
oc get deployment/<deployment> --template='{{.spec.template.metadata.annotations}}'
map[sidecar.istio.io/inject:true]
```
