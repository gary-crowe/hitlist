---
kind: NetworkPolicy
apiVersion: networking.k8s.io/v1
metadata:
  name: allow-same-namespace
  namespace: hitlist
spec:
  podSelector:
    matchLabels:
      app: mysql
  ingress:
  - from:
    - podSelector:
        matchLabels:
          app: theblacklist
    ports:
      - protocol: TCP
        port: 3306
---
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: internet-access
  namespace: hitlist
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
  namespace: hitlist
spec:
  podSelector: {}
  policyTypes:
  - Ingress
  - Egress
