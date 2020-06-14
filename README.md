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
# Create a cluster and deploy the manifests
make

# Make sure you can access the demo app on http://localhost:10080
make open-app
```

Deploy Flux.

```sh
export KUBECONFIG=output/kubeconfig.yaml

kubectl create ns flux
helmfile sync
```

Get the public key of Flux.

```sh
fluxctl --k8s-fwd-ns flux identity
```

Open https://github.com/int128/flux-continuous-deployment-demo/settings/keys and add the deploy key with write access.

Make sure that Flux recognizes the deployment.

```console
% fluxctl --k8s-fwd-ns flux list-workloads -n hellopage
WORKLOAD                        CONTAINER  IMAGE                                                       RELEASE  POLICY
hellopage:deployment/hellopage  app        gcr.io/int128-1313/github.com/int128/hellopage:dev-81f12fd  ready    automated

% fluxctl --k8s-fwd-ns flux list-images -n hellopage
WORKLOAD                        CONTAINER  IMAGE                                           CREATED
hellopage:deployment/hellopage  app        gcr.io/int128-1313/github.com/int128/hellopage
                                           '-> dev-81f12fd                                 14 Jun 20 07:11 UTC
```

You can see Flux log for debug.

```sh
make flux-logs
```

### Deploy the application

```sh
make open-app
```

Push a commit to the default branch of https://github.com/int128/hellopage.

Flux will create a commit to this repository to update the image tag of deployment.

### Clean up

```sh
make delete-cluster
```
