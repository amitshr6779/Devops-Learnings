# What is ArgoCD ?
Argo CD is a continuous delivery tool to accomplish GitOps for Kubernetes environment.

### Installation
Create a namespace:

``` 
kubectl create namespace argocd 
```
Install Argo CD via official YAML file

```
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
```

Check Resources in argocd namespace

```
kubectl get all -n argocd
```

Get default password of Argo CD UI:

```
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo
```
Access Argo CD UI

```
kubectl port-forward svc/argocd-server -n argocd --address 0.0.0.0  8080:443
```
`Now visit to HOST-IP:8080in broweser  to acccess the argocd UI` <br>
`NOTE : Default Login Username = admin`

By Default, reconsile time in arocd is 3 min.
To customize the reconsile time, add reconsile  timeout in argocd configmap
<br>

```
kubectl edit configmap argocd-cm -n argocd
```
```
apiVersion: v1
data:
  timeout.reconciliation: 30s
kind: ConfigMap
metadata:
  annotations:
    kubectl.kubernetes.io/last-applied-configuration: |
      {"apiVersion":"v1","kind":"ConfigMap","metadata":{"annotations":{},"labels":{"app.kubernetes.io/name":"argocd-cm","app.kubernetes.io/part-of":"argocd"},"name":"argocd-cm","namespace":"argocd"}}
  creationTimestamp: "2023-01-14T20:11:47Z"
  labels:
    app.kubernetes.io/name: argocd-cm
    app.kubernetes.io/part-of: argocd
  name: argocd-cm
  namespace: argocd
  resourceVersion: "43385"
  uid: 69132cec-2344-417f-a9d6-a857b4a03044

```

After that restart `argocd-application-controller`  pod  from argocd namespace
