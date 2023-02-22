tkn pipeline start build-and-deploy \
	-w name=hotlist \
	-p deployment-name=theblacklist \
	-p git-url=https://github.com/openshift/pipelines-vote-ui.git \
	-p IMAGE='image-registry.openshift-image-registry.svc:5000/$(context.pipelineRun.namespace)/theblacklist' \
	--use-param-defaults
