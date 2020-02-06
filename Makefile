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
