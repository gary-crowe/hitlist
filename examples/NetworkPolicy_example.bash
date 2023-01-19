---
kind: NetworkPolicy
apiVersion: networking.k8s.io/v1
metadata:
  name: allow-from-openshift-ingress
spec:
  podSelector: {}
  ingress:
  - from:
    - namespaceSelector:
        matchLabels:
          network.openshift.io/policy-group: ingress
---
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: internet-access
  namespace: blacklist
spec:
  podSelector:
    matchLabels:
      app: theblacklist
  policyTypes:
  - Ingress
  ingress:
  - {}
---
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: default-deny
  namespace: blacklist
spec:
  podSelector: {}
  policyTypes:
  - Ingress
  - Egress
