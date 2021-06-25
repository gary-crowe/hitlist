cat <<EOF | oc apply -f -
apiVersion: helm.openshift.io/v1beta1
kind: HelmChartRepository
metadata:
  name: garys-repo
spec:
  name: garys-repo
  connectionConfig:
    url: https://gary-crowe.github.io/my-helm-repository/
EOF
