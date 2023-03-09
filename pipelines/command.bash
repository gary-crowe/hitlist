tkn pipeline start build-and-deploy \
	-w name=shared-workspace,volumeClaimTemplateFile=https://raw.githubusercontent.com/openshift/pipelines-tutorial/pipelines-1.7/01_pipeline/03_persistent_volume_claim.yaml \
	-p deployment-name=theblacklist \
	-p git-url=http://bastion2.zbd.local:3000/gary/blacklist-ui.git \
	-p IMAGE='image-registry.openshift-image-registry.svc:5000/$(context.pipelineRun.namespace)/theblacklist' \
	--use-param-defaults
