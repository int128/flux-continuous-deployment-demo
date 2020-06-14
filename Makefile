CLUSTER_NAME := hellopage
OUTPUT_DIR := output
KUBECONFIG := $(OUTPUT_DIR)/kubeconfig.yaml
export KUBECONFIG

.PHONY: all
all: deploy-app

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

.PHONY: logs-flux
logs-flux:
	kubectl -n flux logs -f -lapp=flux

.PHONY: delete-cluster
delete-cluster:
	kind delete cluster --name $(CLUSTER_NAME)
	-rm $(KUBECONFIG)
