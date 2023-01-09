# What is flux ?
Fluxcd is one of the leading Gitops tool/solutions for synchronizing Kubernetes clusters with code repository like git, ensuring that the cluster state matches exactly the configuration in git.

## Install Flux
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
Now check flux resources is deployed or not in flux-system namespace
```
kubectl get all -n flux-system
```

To update source to sync with diffrent option like interval etc, run the following command.
```
flux create source git <Your-Repo-Name> --url=<YOUR-REPO-URL> --branch=master --interval=30s --username=<YOUR-GIT-USERNAME> --password=<YOU-GIT-TOKEN>
```
To Deploy apps to kubernetes cluster with manifest files, create kustomization. <br>
`Kustomization` defines a pipeline for fetching, decrypting, building, validating and applying Kustomize overlays or plain Kubernetes manifests. 
```
flux create kustomization <REPO-NAME> --source=<REPO-NAME> --path="./Path/of/manifest/inside/repo" --prune=true --interval=10s
```

<br>

**To Uninstal Flux form workspace.**

```
flux uninstall --namespace=flux-system
```
