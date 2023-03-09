# Messing with Tekton pipelines.
1. Create the namespace "hitlist"
2. Instal the following:
```yaml
oc apply -f 01_apply_manifest_task.yaml -f 02_update_deployment_task.yaml
```
3.  Use the command.bash script to launch your pipleine.

Followed from example here: https://docs.openshift.com/container-platform/4.10/cicd/pipelines/creating-applications-with-cicd-pipelines.html#prerequisites
