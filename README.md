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
