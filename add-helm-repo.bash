cat <<EOF | oc apply -f -
apiVersion: helm.openshift.io/v1beta1
kind: HelmChartRepository
metadata:
  name: garys-repo
spec:
  name: garys-repo
  connectionConfig:
    url: https://github.com/gary-crowe/hitlist/my-helm-charts
EOF
