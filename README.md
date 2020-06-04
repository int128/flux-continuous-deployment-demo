# flux-continuous-deployment-demo

This is a demo of Continuous Deployment with Flux [automated deployment of new container images](https://docs.fluxcd.io/en/stable/references/automated-image-update.html).

## Introduction

This is a typical flow of GitOps:

![gitops-basic-flow.svg](gitops-basic-flow.svg)

Continuous Deployment with Flux:

![gitops-continuous-deployment-flow.svg](gitops-continuous-deployment-flow.svg)

## Getting Started

### Set up

You need the following tools:

- Docker
- Kind
- Helmfile
- fluxctl

Deploy the demo app.

```sh
# Create a cluster
make cluster

# Deploy the manifests
make deploy-app

# Make sure you can access the demo app on http://localhost:10080
make open-app
```

Deploy Flux.

```sh
export KUBECONFIG=output/kubeconfig.yaml

kubectl create ns flux
make deploy-flux
```

Get the public key of Flux.

```sh
fluxctl --k8s-fwd-ns flux identity
```

Open https://github.com/int128/flux-continuous-deployment-demo/settings/keys and add the deploy key.

You can see the log of Flux.

```sh
make flux-logs
```

### Deploy the application

```sh
make open-app
```

```sh
make flux-logs
```

Push a commit to the default branch of https://github.com/int128/hellopage.

Flux will create a commit to this repository to update the image tag of deployment.

### Clean up

```sh
make delete-cluster
```
