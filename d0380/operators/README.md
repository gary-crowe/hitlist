1. Create a file called file-integrity-operator-namespace.yaml with the following content:

```yaml
apiVersion: v1
kind: Namespace
metadata:
  labels:
    openshift.io/cluster-monitoring: "true"
  name: openshift-file-integrity
Create the namespace.
```
```bash
[student@workstation ~]$ oc apply -f file-integrity-operator-namespace.yaml
namespace/openshift-file-integrity created
```
2. Enter the new namespace.

```bash
[student@workstation ~]$ oc project openshift-file-integrity
Now using project "openshift-file-integrity" on server "https://api.ocp4.example.com:6443".
```
3. Create a group for the operator.

Operators that are installed using the OLM require a group that matches the namespace name.
Create a file called file-integrity-operator-group.yaml and add the following content:

```yaml
apiVersion: operators.coreos.com/v1
kind: OperatorGroup
metadata:
  name: file-integrity-operator
  namespace: openshift-file-integrity
spec:
  targetNamespaces:
  - openshift-file-integrity
Create the operator group.
```
```bash
[student@workstation ~]$ oc apply -f file-integrity-operator-group.yaml
operatorgroup.operators.coreos.com/file-integrity-operator created
```
4. Create the operator subscription.

The operator must be subscribed to a namespace.
Create the subscription object YAML file called file-integrity-operator-subscription.yaml.

```yaml
apiVersion: operators.coreos.com/v1alpha1
kind: Subscription
metadata:
  name: file-integrity-operator-sub
  namespace: openshift-file-integrity
spec:
  channel: "4.6"
  name: file-integrity-operator
  source: redhat-operators
  sourceNamespace: openshift-marketplace
```
5. Create the subscription object.

```bash
[student@workstation ~]$ oc apply -f file-integrity-operator-subscription.yaml
subscription.operators.coreos.com/file-integrity-operator-sub created
```
6. Verify that the operator installed successfully.

```bash
[student@workstation ~]$ oc describe sub file-integrity-operator-sub
Name:         file-integrity-operator-sub
Namespace:    openshift-file-integrity
Labels:       operators.coreos.com/file-integrity-operator.openshift-file-integrity=
Annotations:  <none>
API Version:  operators.coreos.com/v1alpha1
Kind:         Subscription
...output omitted...
Spec:
  Channel:           4.6
  Name:              file-integrity-operator
  Source:            redhat-operators
  Source Namespace:  openshift-marketplace
...output omitted...
```
