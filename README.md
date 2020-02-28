# continuous-deployment-flux-demo

This is a demo for continuous deployment with Flux.

## Flow

Basic flow of GitOps:

![gitops-basic-flow.svg](gitops-basic-flow.svg)

Continuous deployment using Flux:

![gitops-continuous-deployment-flow.svg](gitops-continuous-deployment-flow.svg)

## Getting Started

### Set up

You need the following tools:

- Docker
- Kind
- Helmfile
- fluxctl

Create a cluster.

```sh
make cluster
export KUBECONFIG=output/kubeconfig.yaml
```

Deploy the manifests manually.

```sh
make deploy
make port-forward
```

Open http://localhost:10080 and make sure the demo app is shown.

Deploy Flux.

```sh
kubectl create ns flux
helmfile sync
```

Add the deploy key to the GitHub repository.
See the [document](https://docs.fluxcd.io/en/stable/tutorials/get-started-helm.html#giving-write-access) for details.

```sh
fluxctl --k8s-fwd-ns flux identity
```

You can see the log of Flux.

```sh
make flux-logs
```

### Deploy

```sh
make port-forward
```

Open http://localhost:10080 and make sure the demo app is shown.

```sh
make flux-logs
```

Push a commit to the default branch of https://github.com/int128/hellopage.

Flux CD will push a commit to this repository for updating the image tag.

### Clean up

```sh
make delete-cluster
```
