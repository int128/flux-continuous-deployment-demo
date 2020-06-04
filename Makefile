CLUSTER_NAME := hellopage
OUTPUT_DIR := output
KUBECONFIG := $(OUTPUT_DIR)/kubeconfig.yaml
export KUBECONFIG

.PHONY: all
all:

.PHONY: cluster
cluster: $(KUBECONFIG)
$(KUBECONFIG):
	kind create cluster --name $(CLUSTER_NAME)

.PHONY: deploy-app
deploy-app: cluster
	kubectl apply -f manifests/
	kubectl -n hellopage rollout status deployment hellopage

.PHONY: open-app
open-app:
	open http://localhost:10080
	kubectl -n hellopage port-forward svc/hellopage 10080:80

.PHONY: deploy-flux
deploy-flux: cluster
	helmfile sync

.PHONY: flux-logs
flux-logs:
	kubectl -n flux logs -f -lapp=flux

.PHONY: cluster
delete-cluster:
	kind delete cluster --name $(CLUSTER_NAME)
	-rm $(KUBECONFIG)
