#  Kubernetes Secrets With Sealed Secrets
Kubernetes Secrets are resources that help you store sensitive information, such as passwords, keys, certificates, OAuth tokens, and SSH keys.
</br> But the problem with Kubernetes secrets is they store sensitive information as a base64 string. Anyone can decode the base64 string to get the original data from the Secret manifest.
<br> Thus, the Secret manifest file can’t be stored in a source-code repository, So to resolve this Bitnami Labs has created an open-source tool called **Sealed Secrets**
<br>

#### Sealed Secrets
Sealed Secrets is comprised of two components:

<summary> A cluster-side Kubernetes controller/operator </summary>
<summary> A client-side utility called kubeseal </summary> <br>

The kubeseal utility allows you to seal Kubernetes Secrets using the asymmetric crypto algorithm. The SealedSecrets are Kubernetes resources that contain encrypted Secrets that only the controller can decrypt.
<br> <br>
SealedSecret resources are just a recipe for creating Kubernetes Secret resources. <br>
When you apply it on the Kubernetes cluster, the cluster-side operator reads the SealedSecret, generates the Kubernetes Secret, and applies the generated Secret on the cluster. The Kubernetes Pod can then use the Secret conventionally.

<br>

### Install Sealed Secret

1.  To install Kubeseal CLI tool <br>
Pick the latest release version of kubeseal cli from [here](https://github.com/bitnami-labs/sealed-secrets/releases)

```
wget https://github.com/bitnami-labs/sealed-secrets/releases/download/v0.10.0/kubeseal-linux-amd64 -O kubeseal
sudo install -m 755 kubeseal /usr/local/bin/kubeseal
```

2. To install Kubeseal controller <br>
Pick the latest release version controller from [here](https://github.com/bitnami-labs/sealed-secrets/releases)

```
wget https://github.com/bitnami-labs/sealed-secrets/releases/download/v0.19.3/controller.yaml
kubectl  apply -f controller.yaml
```
