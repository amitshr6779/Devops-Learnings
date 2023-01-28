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

<br>
To expose argocd-server outside of k8s cluster as  ingress
<br> 

Create `argocd-ingress.yaml` file for argocd

```
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: argocd-server-ingress
  namespace: argocd
  annotations:
    cert-manager.io/cluster-issuer: letsencrypt-prod
    kubernetes.io/ingress.class: nginx
    kubernetes.io/tls-acme: "true"
    nginx.ingress.kubernetes.io/ssl-passthrough: "true"
    # If you encounter a redirect loop or are getting a 307 response code
    # then you need to force the nginx ingress to connect to the backend using HTTPS.
    #
    nginx.ingress.kubernetes.io/backend-protocol: "HTTPS"
spec:
  rules:
  - host: argocd.example.com
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: argocd-server
            port:
              name: https
  tls:
  - hosts:
    - argocd.example.com
    secretName: argocd-secret # do not change, this is provided by Argo CD
```
<br>

Now create arocd `argocd-certifacte.yaml` file

```
apiVersion: cert-manager.io/v1
kind: Certificate
metadata:
  name: argocd.example.com
  namespace: argocd
spec:
  #secretName: argocd.example.com-tls
  secretName: argocd-secret
  issuerRef:
    name: letsencrypt-prod
    kind: ClusterIssuer
  commonName: argocd.example.com
  dnsNames:
  - argocd.example.com
```

```
kubectl apply -f argocd-ingress.yaml
kubectl apply -f argocd-certficate.yaml
```

Now , access argocd ui in broweser i.e **argocd.example.com**

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

### To Remove ArgoCD from K8s cluster

```
kubectl delete -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
```
