CLUSTER_NAME := hellopage
OUTPUT_DIR := output
KUBECONFIG := $(OUTPUT_DIR)/kubeconfig.yaml
export KUBECONFIG

.PHONY: all
all: cluster

.PHONY: cluster
cluster: cluster.yaml
	kind create cluster --name $(CLUSTER_NAME) --config cluster.yaml
	kubectl apply -f manifests/
	kubectl -n hellopage rollout status deployment hellopage

.PHONY: logs-flux
logs-flux:
	kubectl logs -f -lapp=flux

.PHONY: delete-cluster
delete-cluster:
	kind delete cluster --name $(CLUSTER_NAME)
	-rm $(KUBECONFIG)
