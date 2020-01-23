# hellopage-manifests

This contains the manifests for https://github.com/int128/hellopage.


## Getting Started

```sh
kubectl apply -f hellopage.yaml
```

```sh
kubectl proxy
```

Open http://localhost:8001/api/v1/namespaces/hellopage/services/hellopage:http/proxy/ in your browser.


### Continuous deployment with Flux

See https://docs.fluxcd.io.

```sh
# Install a daemon
fluxctl install --git-user=int128 --git-email=int128@users.noreply.github.com --git-url=git@github.com:int128/hellopage-manifests --namespace=hellopage | kubectl apply -f -

# Show the deploy key
fluxctl identity --k8s-fwd-ns hellopage

# Sync now
fluxctl sync --k8s-fwd-ns hellopage
```

When you change the default branch of https://github.com/int128/hellopage,
the flux will update the image tag of the deployment.
