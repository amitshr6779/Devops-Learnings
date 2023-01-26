## What is ingress ?
In Kubernetes, an Ingress is an object that allows access to your Kubernetes services from outside the Kubernetes cluster. You configure access by creating a collection of rules that define which inbound connections reach which services.
<br>

## How to Use Nginx Ingress Controller ?
####  Install Nginx Ingress Controller

* Using Helm
```
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update
helm install ingress-nginx ingress-nginx/ingress-nginx
```
To install other ways like Yaml Manifest, check [nginx ingess](https://kubernetes.github.io/ingress-nginx/deploy/#quick-start) offical docs.

Now, To check nginx ingress controller

```
kubectl get services ingress-nginx-controller
```
<br>

***Kubernetes ingress exposes a web application to the outside of the cluster. And, the application is reachable over HTTP by default which is not secure. To make it secue , cofigure cert manager and lets encrypt***

#### Install cert manager

* Using Helm
```
helm repo add jetstack https://charts.jetstack.io
helm repo update
helm install \
  cert-manager jetstack/cert-manager \
  --namespace cert-manager \
  --create-namespace \
  --version v1.11.0 \
  --set installCRDs=true
```

* Using Kubectl
```
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.11.0/cert-manager.crds.yaml
```

For more details about cert-manager, refer [here](https://cert-manager.io/docs/installation/helm/)

#### Configure Let’s Encrypt Issuer
To configure Kubernetes Nginx Ingress Controller LetsEncrypt ,configure Let’s Encrypt Issuer. Naviagte [Certmanger ACME](https://cert-manager.io/docs/configuration/acme/) page for more details about issuning certficate

```
apiVersion: cert-manager.io/v1
kind: ClusterIssuer
metadata:
  name: letsencrypt-prod
  namespace: default
spec:
  acme:
    # The ACME server URL
    server: https://acme-v02.api.letsencrypt.org/directory
    # Email address used for ACME registration
    email: give-your@email.com
    # Name of a secret used to store the ACME account private key
    privateKeySecretRef:
      name: letsencrypt-prod
    # Enable the HTTP-01 challenge provider
    solvers:
    - http01:
        ingress:
          class: nginx
```
<br>

***Now to test ingress + lets`s encrypt create Deployment and service for nginx app***

`vi Deployment.yaml`

```
kind: Deployment
apiVersion: apps/v1
metadata:
  name: nginx-app
  namespace: default
  labels:
    app: nginx-app
spec:
  replicas: 1
  selector:
    matchLabels:
      app: nginx-app
  template:
    metadata:
      labels:
        app: nginx-app
    spec:
      containers:
      - name: nginx
        image: "nginx"
```

```
kubectl  apply -f Deployment.yaml
```

`vi service.yaml`

```
apiVersion: v1
kind: Service
metadata:
  name: nginx-app
  namespace: default
spec:
  selector:
    app: nginx-app
  ports:
  - name: http
    targetPort: 80
    port: 80
```

```
kubectl  apply -f service.yaml
```

#### Create Nginx Ingress Let’s Encrypt TLS Certificate

`vi lets-encrypt.yaml`

```
apiVersion: cert-manager.io/v1
kind: Certificate
metadata:
  name: <Your-DNS>
  namespace: default
spec:
  secretName: <Your-DNS>-tls
  issuerRef:
    name: letsencrypt-prod
    kind: ClusterIssuer
  commonName: <Your-DNS>
  dnsNames:
  - <Your-DNS>
```

```
kubectl  apply -f lets-encrypt.yaml
kubectl get certificates -n default
kubectl get secrets -n default

```

#### Create Nginx Ingress Resources/Rules for exposing the apps outsie the cluster and Point Nginx Ingress Let’s Encrypt Certificate

`vi ingress.yaml`

```
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  annotations:
    cert-manager.io/cluster-issuer: letsencrypt-prod
    kubernetes.io/ingress.class: nginx
  name: nginx-ingres
  namespace: default
spec:
  ingressClassName: nginx
  rules:
    - host: <Your-DNS>
      http:
         paths:
           - pathType: Prefix
             backend:
               service:
                 name: nginx-app
                 port:
                   number: 80
             path: /
  tls:
  - hosts:
    - <Your-DNS>
    secretName: <Your-DNS>-tls
```

```
kubectl  apply -f ingress.yaml  
kubect get ing -n deafult
```

