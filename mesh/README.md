# Instructions to implement this code.
This code contains k8's manifests to create the hitlist app and use service mesh for reporting/proxy etc.
Used as a learning exercise to muck about with istio

1. Create a suitable namespace (project).
```bash
NAMESPACE=hitlist
oc new-project ${NAMESPACE}
```
2. Add this namespace as an istio member.
```bash
oc patch servicemeshmemberroll/default -n istio-system --type=merge -p '{"spec": {"members": ["hitlist"]}}'
```
3. Deploy the mysql & flask deployments. I have created a kustomize file to cwmake your life easier.  These will source pre-built docker images from quay.io
```bash
oc create -k .
```
4. Extract the base DNS for your deployment
```bash
export APP_SUBDOMAIN=$(oc get route -n istio-system | grep -i kiali | awk '{ print $2 }' | cut -f 2- -d '.')
```
5. Deploy the istio route/ingress & virtual resources.
```bash
cat ingress_mtls.yml | envsubst | oc apply -f -
```
6. Check the route has been created
```bash
oc get routes -n istio-system blacklist
NAME        HOST/PORT                                        PATH   SERVICES               PORT    TERMINATION   WILDCARD
blacklist   blacklist-hitlist-istio-system.apps.burn.local          istio-ingressgateway   http2                 None
```

# Notes
### Extract the Istio ingress gateway URL
```bash
oc get route istio-ingressgateway -n istio-system \
-o template --template '{{ "http://" }}{{ .spec.host }}'
```

### Grab the kialli URL
```bash
oc get route kiali -n istio-system \
-o template --template '{{ "https://" }}{{ .spec.host }}'
```
or manually edit:
```bash
oc -n istio-system edit smmr
```
### Verify if the service mesh control plane pods are running and the status of installation:
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
