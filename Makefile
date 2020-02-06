CLUSTER_NAME := hellopage
OUTPUT_DIR := output
KUBECONFIG := $(OUTPUT_DIR)/kubeconfig.yaml
export KUBECONFIG

.PHONY: all
all:

.PHONY: cluster
cluster: $(OUTPUT_DIR)/kubeconfig.yaml
$(OUTPUT_DIR)/kubeconfig.yaml:
	kind create cluster --name $(CLUSTER_NAME)

.PHONY: deploy
deploy: cluster
	kubectl apply -f manifests/

.PHONY: port-forward
port-forward:
	kubectl -n hellopage port-forward svc/hellopage 10080:80

.PHONY: flux-logs
flux-logs:
	kubectl -n flux logs -f -lapp=flux

.PHONY: cluster
delete-cluster:
	kind delete cluster --name $(CLUSTER_NAME)
