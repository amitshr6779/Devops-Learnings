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
    namespace: default
stringData:
    MYSQL_USER: root
    MYSQL_PASSWORD: super-Secret-Password!!!!
EOF
```
For Encrytion
```
sops -e secret.yml
sops -e -i secret.yml
```
For Decryption
```
sops -d sops-test-secret.yml
```

## Integration of Mozila SOPS with Flux
### Install Flux



