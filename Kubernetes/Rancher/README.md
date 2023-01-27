# What is rancher ?

* Rancher is open-source software Kubernetes-as-a-Service tool.
* Through Rancher platform you can create the cluster in different clouds or import an existing one as well
* Its also an Platform for Kubernetes IDE

<br>

**Lets's Install Rancher on a Kubernetes Cluster**

**Using Helm**
#### Add the Helm Repo for helm
```
helm repo add rancher-stable https://releases.rancher.com/server-charts/stable
```
#### Create a Namespace for Rancher
```
kubectl create namespace cattle-system
```
#### Finally, Install rancher
```
helm install rancher rancher-stable/rancher   --namespace cattle-system   --set hostname=<your-DNS-for-rancher-ui>  --set replicas=3 --set tls=external

kubect get all -n cattle-system
```
#### After successful installtion of rancher, add nginx ingress class  annotation and point Nginx Ingress Let’s Encrypt Certificate in rancher ingress

```
kubect get ing -n cattle-system
kubectl edit ing rancher  -n cattle-system
```

```
kubernetes.io/ingress.class: nginx
```
```
  tls:
  - hosts:
    - <Your_rancher-ui-DNS>
    secretName: <Your_rancher-ui-DNS>-tls
```
#### Create Let’s Encrypt TLS Certificate for rancher ingress
`vi cetificate.yaml`
```
apiVersion: cert-manager.io/v1
kind: Certificate
metadata:
  name: <Your_rancher-ui-DNS>
  namespace: cattle-system
spec:
  secretName: <Your_rancher-ui-DNS>-tls
  issuerRef:
    name: letsencrypt-prod
    kind: ClusterIssuer
  commonName: <Your_rancher-ui-DNS>
  dnsNames:
  - <Your_rancher-ui-DNS>
```
#### Finally, extract Rancher UI password

```
kubectl -n cattle-system exec $(kubectl -n cattle-system get pods -l app=rancher | grep '1/1' | head -1 | awk '{ print $1 }') -- reset-password
```
<br>

**Refrences**
* [Rancher](https://ranchermanager.docs.rancher.com/v2.5/pages-for-subheaders/install-upgrade-on-a-kubernetes-cluster#install-the-rancher-helm-chart)
* [Medium Blog by Saiyam Pathak](https://faun.pub/rancher-one-place-for-all-kubernetes-clusters-51586d72858a)
