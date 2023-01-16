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
kubeseal --help
```

2. To install Kubeseal controller <br>
Pick the latest release version controller from [here](https://github.com/bitnami-labs/sealed-secrets/releases)

```
wget https://github.com/bitnami-labs/sealed-secrets/releases/download/v0.19.3/controller.yaml
kubectl  apply -f controller.yaml
```

**Lets Test the Encyption**
<summary> Generete a secret and encrypt it using kubeseal </summary>

```
kubectl --namespace default create secret generic mysecret --dry-run=client  --from-literal foo=bar --from-literal name=amit  --output yaml

kubectl --namespace default create secret generic mysecret --dry-run=client  --from-literal foo=bar --from-literal name=amit  --output yaml | kubeseal | tee mysecret.yaml

kubectl create --filename mysecret.yaml

kubectl get secret mysecret --output yaml
```
<summary> Encrypt secret from yaml file </summary>`

```
cat <<'EOF' >> test-secret.yaml
apiVersion: v1
stringData:
  foo: secret123
kind: Secret
metadata:
  name: stringsecret
  namespace: default
EOF
```
```
kubeseal --format yaml < test-secret.yaml > test-secret.yaml
kubectl apply -f test-secret.yaml
kubectl get secret stringsecret --output yaml
```

**There are three scopes you can create your SealedSecrets with** <br>

`strict (default)`: In this case, you need to seal your Secret considering the name and the namespace. You can’t change the name and the namespaces of your SealedSecret once you've created it. If you try to do that, you get a decryption error.  <br>

```
kubeseal --format yaml --scope strict <secret-cw.yaml >sealedsecret-st.yaml
```
<br>

`namespace-wide`: This scope allows you to freely rename the SealedSecret within the namespace for which you’ve sealed the Secret.  <br>

```
kubeseal --format yaml --scope namespace-wide <secret-cw.yaml >sealedsecret-nw.yaml
```
<br>

`cluster-wide`: This scope allows you to freely move the Secret to any namespace and give it any name you wish.

```
kubeseal --format yaml --scope cluster-wide <secret-cw.yaml >sealedsecret-cw.yaml
```
