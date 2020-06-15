# flux-continuous-deployment-demo

This is a demo of Continuous Deployment with Flux using the feature of [automated deployment of new container images](https://docs.fluxcd.io/en/stable/references/automated-image-update.html).


## Introduction

In a typical GitOps flow, you need to build a new Docker image and update the manifest to deploy the application.

![gitops-basic-flow.svg](gitops-basic-flow.svg)

In continuous deployment flow, you only need to build a new Docker image. Flux will update the manifest when a newer image is found.

![gitops-continuous-deployment-flow.svg](gitops-continuous-deployment-flow.svg)


## Demo

This demo uses the following repositories:

- Application repository: https://github.com/int128/hellopage
- Docker registry: https://gcr.io/int128-1313/github.com/int128/hellopage
- Manifest repository: https://github.com/int128/flux-continuous-deployment-demo


### Set up

You need to install the following tools:

- Docker
- Kind
- Helmfile
- fluxctl

Create a cluster.

```sh
# Create a cluster and deploy the application manifests
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

Open https://github.com/int128/flux-continuous-deployment-demo/settings/keys and add the deploy key with write access.
You can get the deploy key as follows:

```sh
fluxctl --k8s-fwd-ns flux identity
```

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


### Update the application

Open https://github.com/int128/hellopage and create a commit.
Google Cloud Build will build an image and push it to GCR.

Then Flux will create a commit to this repository for updating the image tag of deployment.
You can see the new version within a minute.


### Clean up

```sh
make delete-cluster
```
