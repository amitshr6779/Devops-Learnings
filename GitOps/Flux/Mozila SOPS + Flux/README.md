# What is Mozila SOPS ?
<summary> SOPS stands for  Secrets OPerationS </summary>
<summary> It takes a kubernetes secret and encrypts it while maintaining the original structure of the secrets file itself. This is handy because it encrypts the secret value but leaves the keys as plain text </summary>
<summary> It doesn’t do the encryption itself. It leverages other encryption technologies like PGP, AGE, GCP KMS, Azure key vault, Hashicorp Vault, etc </summary> 

### Install SOPS
mkdir SOPS+flux  && cd SOPS+flux
Download the binary from [here](https://github.com/mozilla/sops/releases)
```
wget https://github.com/mozilla/sops/releases/download/v3.7.3/sops_3.7.3_amd64.deb
sudo dpkg -i ./sops_3.7.3_amd64.deb
rm ./sops_3.7.3_amd64.deb
```
Now lets test sops installed successfully or not
```
sops -v
```


## Age
Age is a tool to encrypt files. It doesn’t care about the format of the file itself. To encrypt only the values or parts of a file we need to rely on Sops. Age is only a tool that Sops will use.

### Install Age
Download the binary from [here](https://github.com/FiloSottile/age/releases)
```
wget -O age.tar.gz https://github.com/FiloSottile/age/releases/download/v1.0.0/age-v1.0.0-linux-amd64.tar.gz
```

Extract the file and move it /usr/local/bin
```
tar xf age.tar.gz
sudo mv age/age /usr/local/bin
sudo mv age/age-keygen /usr/local/bin
rm -rm age
rm age.tar.gz
```
Now, Test installtion of age is successful or not
```
 age -version
 age-keygen -version
 age-keygen --help
```
## Let’s make a key
Generate an age key with age using age-keygen, the key name must end with .agekey to be detected as an age key.
```
age-keygen -o age.agekey
export SOPS_AGE_KEY_FILE=age.agekey
```
```
cat age.agekey
created: 2023-01-06T13:07:26Z
public key: age1p7zzzyj6qajqqdy9qssz3exwn8hws9l5swjxqhx7ryuznhza0yjsaeast4
AGE-SECRET-KEY-1Y9ALJL7HRYVW82WEZTN87HWSSE8GWF7GFUV7ACVS8ECTGDV0ZRZQEMGWCE
```
`NOTE`: The public key is the one we use to encrypt and the secret key decrypts data and must be kept private, not shared or commit be git 
<br> 
<br>

### Test Encryption and Decryption 
Next, make encryption easier by creating a small config file for SOPS. This allows you to encrypt quickly without telling SOPS which key you want to use and it will only check *.yml files. <br>
So, let's create a `.sops.yaml` file like this one in the root directory of your flux repository.

**Note**: Remember to add YOUR public key to the age key below in the YAML file.
```
cat <<'EOF' >> .sops.yaml
creation_rules:
  - path_regex: .*.yml
    encrypted_regex: '^(data|stringData)$'
    age: age1p7zzzyj6qajqqdy9qssz3exwn8hws9l5swjxqhx7ryuznhza0yjsaeast4
EOF
```
And let us test it.

```
cat <<'EOF' >> secret.yml
apiVersion: v1
kind: Secret
metadata:
  name: mysql-secret
type: kubernetes.io/basic-auth
stringData:
  password: test1234
EOF
```
For Encrytion
```
sops -e secret.yml
sops -e -i secret.yml
```
After Encryption our `secret.yml` will look like this:
```
cat secret.yml

apiVersion: v1
data:
    sops: ENC[AES256_GCM,data:BThY4xVa+SM=,iv:odFiupGKWtOJKrZ63idvgtgpDGCCPdWijWQb1NTeIDY=,tag:D3oFsdOYFHkvlTFUyq6s9Q==,type:str]
kind: Secret
metadata:
    creationTimestamp: null
    name: sopstest
sops:
    kms: []
    gcp_kms: []
    azure_kv: []
    hc_vault: []
    age:
        - recipient: age1p7zzzyj6qajqqdy9qssz3exwn8hws9l5swjxqhx7ryuznhza0yjsaeast4
          enc: |
            -----BEGIN AGE ENCRYPTED FILE-----
            YWdlLWVuY3J5cHRpb24ub3JnL3YxCi0+IFgyNTUxOSBPdjNaYlpZNDJ1cGlaR0xO
            dmFnOG9JNExNYkVQTGZLdjc0U2lmSWZuWFJZCkowbSt1NHlqT1BiWXloK1luOTZl
            dE5WWFlqL2hSMm9ScDFUZTVnYnprUlEKLS0tIFN5cjRGeG1hUmVORjhxb2pYeGFo
            ak05OWJSWnZtNng2TWlRWnVsd1Z1SXcKvlJ2v8kjlzjh6TCbuipXb3g4rG3F2DAs
            rpxm7EiTR51/GQbcQcU8qd/FC0KKOAifmLeW7PXODqk6pU0gdSPF1Q==
            -----END AGE ENCRYPTED FILE-----
    lastmodified: "2022-10-04T11:43:57Z"
    mac: ENC[AES256_GCM,data:MdCIUTrfZX4/0T5D5eqQtywTLJjWazgNd+oq//x7I88OKiA9vKuG22/K0rn7I6Rc9Motbilf3lCbz1Une8HJ9Z1L9BVcaFJJid13TCTm01+E//vCKNJwDfjnX5IkemUlsrPnWN/2IoIvqlgeUZUKZmfIzYWBAKvkYDz9L3DsRFo=,iv:ZtPtLBUw00g8C+UBNwvfgTcjzGpumv3xkMS8ClmVmA4=,tag:1kXPMR8+scKwAg1nKhz5QA==,type:str]
    pgp: []
    encrypted_regex: ^(data|stringData)$
    version: 3.7.3
```
For Decryption
```
sops -d sops-test-secret.yml
```

## Integration of Mozila SOPS with Flux
### Install Flux
To install Flux for your respective operating system, check out the offical installation docs by flux [here](https://fluxcd.io/flux/installation/)

For example, to install flux on  Ubuntu, run the following command:
```
curl -s https://fluxcd.io/install.sh | sudo bash
```

To add auto complete of flux command, run the following command.
```
. <(flux completion bash)
```

To check that the installation was successful and that the Kubernetes cluster you’re using is compatible with Flux, run the following command.
```
flux check --pre
```

To configures the Kubernetes cluster to sync with the repository, run the following command. <br>
`` flux bootstrap`` will creates the GitHub repository if it doesn’t exist and commits the toolkit to the main or master branch. <br>
*Note:* add path flux at the end of bootsrrap path
```
flux bootstrap git --url=<YOUR-GIT-REPO-URL> --branch=master --username=<YOUR-GIT-USERNAME> --password=<YOUR-GIT-TOKEN> --token-auth=true --path=<./YOUR/MANIFEST/PATH/IN/REPO/flux>
```
To update source to sync with diffrent option like interval etc, run the following command.
```
flux create source git <Your-Repo-Name> --url=<YOUR-REPO-URL> --branch=master --interval=30s --username=<YOUR-GIT-USERNAME> --password=<YOU-GIT-TOKEN>
```
<br>

Create a secret with the age private key i.e `age.agekey` created in above steps
```
cat age.agekey | kubectl create secret generic sops-age --namespace=flux-system --from-file=age.agekey=/dev/stdin
```
Above command creates a generic secret called sops-age with our key in the flux-system namespace. The secret exists only inside the flux-system namespace so that only the pods in that namespace have permission to read it. <br>

Now,Test the secret created or not in flux-system namespace
```
kubectl  get secret -n flux-system
NAME                                  TYPE                                  DATA   AGE
default-token-ccksf                   kubernetes.io/service-account-token   3      9m1s
flux-system                           Opaque                                2      8m59s
flux-test                             Opaque                                2      7m45s
helm-controller-token-5rshs           kubernetes.io/service-account-token   3      8m59s
kustomize-controller-token-mrrqm      kubernetes.io/service-account-token   3      8m59s
notification-controller-token-lfjhj   kubernetes.io/service-account-token   3      8m59s
sops-age                              Opaque                                1      15s
source-controller-token-glj25         kubernetes.io/service-account-token   3      8m59s

```
<br>

**Configure in-cluster secrets decryption**  <br>
Create a kustomization for reconciling the secrets on the cluster:

```
flux create kustomization <REPO-NAME> --source=<REPO-NAME> --path="./Path/of/manifest/inside/repo" --prune=true --interval=10s --decryption-provider=sops --decryption-secret=sops-age
```

## Let`s test our encrytion decrytion of secret file.
<summary> Push your encryted file to Github repo </sumaary> 
<br> <br>

![Screenshot from 2023-01-09 01-36-00](https://user-images.githubusercontent.com/84858868/211216714-169326b0-e7fd-4a5e-9eba-580c6a0d4319.png)

<summary> Now Lets check secret, in kubernetes cluster </summary>

```
kubectl  get secret
NAME                  TYPE                                  DATA   AGE
default-token-2nlbl   kubernetes.io/service-account-token   3      29m
mysql-secret          kubernetes.io/basic-auth              1      10s

```
```
 kubectl  edit secret mysql-secret
 apiVersion: v1
data:
  password: dGVzdDEyMzQ=
kind: Secret
metadata:
  creationTimestamp: "2023-01-07T09:38:53Z"
  labels:
    kustomize.toolkit.fluxcd.io/name: flux-test
    kustomize.toolkit.fluxcd.io/namespace: flux-system
  name: mysql-secret
  namespace: default
  resourceVersion: "6542"
  uid: 5a9d40b3-970f-4c44-845d-e09259e3268f
type: kubernetes.io/basic-auth
```
Above we can see that our encrypted value of `password` is decrypted and applied in cluster as base64 encoded value.
For further clarification,  we decode above base64 encoded value and verify it.
```
echo dGVzdDEyMzQ= | base64 --decode
test1234
```
<summary> Now let`s deploy MySql pod , and commit your manifest to git repo at the specfied path </path> <br>
<br>

![Screenshot from 2023-01-09 02-31-57](https://user-images.githubusercontent.com/84858868/211218987-64a3bb0b-fd38-4b4a-91d5-474786b4ccd8.png)

Now , we can check in cluster, MySql pod is deployed successfully.
```
kubectl get pods
NAME                     READY   STATUS    RESTARTS   AGE
mysql-75694ccdf6-kwvsg   1/1     Running   0          135m
```
<br>
Now, exec inside pod , login to MySql DB

```
kubectl  exec -it mysql-75694ccdf6-kwvsg bash
```
<br> 

![Screenshot from 2023-01-09 02-46-01](https://user-images.githubusercontent.com/84858868/211219498-65dbdf74-828c-42f4-b69c-455816574339.png)

Finally we can login MySql DB, through secret applied in cluster

## Refrences
https://fluxcd.io/flux/guides/mozilla-sops/  <br>
https://fluxcd.io/flux/components/kustomize/kustomization/#secrets-decryption
