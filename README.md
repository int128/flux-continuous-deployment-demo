# hellopage-flux-cd

This is a demo for continuous deployment with Flux CD.

## Getting Started

You need the following tools:

- Docker
- Kind
- Helmfile

Create a cluster.

```sh
make cluster
export KUBECONFIG=output/kubeconfig.yaml
```

Deploy the manifests manually.

```sh
kubectl apply -f manifests/
kubectl proxy
```

Open http://localhost:8001/api/v1/namespaces/hellopage/services/hellopage:http/proxy/ in the browser
and make sure the demo app is deployed.

Deploy Flux CD.

```sh
helmfile sync
```

Push a commit to the default branch of https://github.com/int128/hellopage.
Flux CD will push a commit to this repository for updating the image tag.
