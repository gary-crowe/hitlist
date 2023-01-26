Guided Exercise: Deploying Kubernetes Applications on OpenShift
In this exercise, you will deploy an application on OpenShift using standard Kubernetes resources.

Outcomes

You should be able to:

Interact with OpenShift using the Kubernetes kubectl CLI.

Deploy Kubernetes resources using either the kubectl or oc commands.

As the student user on the workstation machine, use the lab command to prepare your system for this exercise.

[student@workstation ~]$ lab k8s-deploy start
Procedure 1.1. Instructions

As the admin user, configure a namespace and rolebinding for the developer user.

Use the oc login command to log in as the administrator and change to the ~/DO380/labs/k8s-deploy/ directory.

[student@workstation ~]$ oc login -u admin -p redhat \
  https://api.ocp4.example.com:6443

Login successful.

...output omitted...
[student@workstation ~]$ cd ~/DO380/labs/k8s-deploy/
Using the kubectl CLI and the provided manifest, create a namespace and provide the developer user with appropriate access.

[student@workstation k8s-deploy]$ kubectl create -f ns-and-rbac.yml
namespace/k8s-deploy created
rolebinding.rbac.authorization.k8s.io/hello-dev created
As the developer user, deploy the Kubernetes resources.

Use the oc login command to log in as the developer user.

[student@workstation k8s-deploy]$ oc login -u developer -p developer
Login successful.

You have one project on this server: "k8s-deploy"

Using project "k8s-deploy".
Create a plain Kubernetes deployment, service, and ingress using the kubectl CLI and the provided manifest.

[student@workstation k8s-deploy]$ kubectl apply -f hello.yml
deployment.apps/hello created
service/hello created
ingress.networking.k8s.io/hello created
Verify that the deployment is successful.

[student@workstation k8s-deploy]$ kubectl get ingresses.v1.networking.k8s.io
NAME    CLASS    HOSTS                         ADDRESS   PORTS   AGE
hello   <none>   hello.apps.ocp4.example.com             80      7s

[student@workstation k8s-deploy]$ curl hello.apps.ocp4.example.com
<html>
  <body>
    <h1>Hello, world from nginx!</h1>
  </body>
</html>
Deploy using the Kubernetes-native configuration system: Kustomize.

As the admin user, create the k8s-deploy-prod namespace.

[student@workstation k8s-deploy]$ oc login -u admin -p redhat
Login successful.
...output omitted...
[student@workstation k8s-deploy]$ kubectl create namespace k8s-deploy-prod
namespace/k8s-deploy-prod created
Review the provided files in the base and prod overlay Kustomize directories located at ~/DO380/labs/k8s-deploy/base/ and ~/DO380/labs/k8s-deploy/overlays/prod/.

Deploy the base and overlay with Kustomize.

[student@workstation k8s-deploy]$ kubectl apply -k overlays/prod
service/hello created
deployment.apps/hello created
ingress.networking.k8s.io/hello created
Verify that the deployment is successful.

[student@workstation k8s-deploy]$ kubectl get ingresses.v1.networking.k8s.io \
  -n k8s-deploy-prod
NAME    CLASS    HOSTS                                      ADDRESS   PORTS   AGE
hello   <none>   deploying-practice.apps.ocp4.example.com             80      7s

[student@workstation k8s-deploy]$ curl deploying-practice.apps.ocp4.example.com
Hi!
NOTE
The container name is required to merge the change to the container image.

Update the ~/DO380/labs/k8s-deploy/overlays/prod/kustomization.yml file to change the tag of the image from the base. The file should look similar to the following:

apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization
namespace: prod
bases:
  - ../../base
images:
  - name: quay.io/redhattraining/versioned-hello
    newTag: v1.1
Optionally, compare your changes to the solution file located at ~/DO380/solutions/k8s-deploy/overlays/prod/kustomization.yml.

Deploy the patch and verify that the deployment is successful.

[student@workstation k8s-deploy]$ kubectl apply -k overlays/prod
service/hello unchanged
deployment.apps/hello configured
ingress.networking.k8s.io/hello unchanged

[student@workstation k8s-deploy]$ curl deploying-practice.apps.ocp4.example.com
Hi! v1.1
Change to the /home/student/ directory.

[student@workstation k8s-deploy]$ cd ~
Finish

On the workstation machine, use the lab command to complete this exercise. This is important to ensure that resources from previous exercises do not impact upcoming exercises.

[student@workstation ~]$ lab k8s-deploy finish
