## What is Helm ?
Helm is a package manager for Kubernetes. A package is called a ***Chart*** . <br> Helm lets you package and deploy complete applications in Kubernetes. <br>
Helm keeps a release history of all deployed charts in a dedicated workspace. This makes easier application updates and rollbacks if something wrong happens.

<br>

### Install Helm
Pick the latest release binary from [here](https://github.com/helm/helm/releases)

```
curl -LO https://get.helm.sh/helm-v3.4.0-linux-amd64.tar.gz
tar -C /tmp/ -zxvf helm-v3.4.0-linux-amd64.tar.gz
rm helm-v3.4.0-linux-amd64.tar.gz
mv /tmp/linux-amd64/helm /usr/local/bin/helm
chmod +x /usr/local/bin/helm

helm version
helm --help
```
Check [here](https://helm.sh/docs/intro/install/) other ways to install helm.

### Create helm chart

```
mkdir helm && cd helm
helm create <your-chart-name>
```
This will create chart structure  like this

![Screenshot from 2023-01-21 20-16-37](https://user-images.githubusercontent.com/84858868/213872221-fc7b0a2c-6d08-4a25-99fc-3278ef07e24a.png)

`Chart.yaml:` A YAML file containing information about the chart. <br>
`charts:` A directory containing any charts upon which this chart depends on. <br>
`templates:` this is where Helm finds the YAML definitions for your Services, Deployments, and other Kubernetes objects. You can add or replace the generated YAML files for your own. <br>
`templates/NOTES.txt:` This is a templated, plaintext file that gets printed out after the chart is successfully deployed. This is a useful place to briefly describe the next steps for using the chart. <br>
`templates/_helpers.tpl:` That file is the default location for template partials. Files whose name begins with an underscore are assumed to not have a manifest inside. These files are not rendered to Kubernetes object definitions but are available everywhere within other chart templates for use. <br>
`templates/tests:` tests that validate that your chart works as expected when it is installed <br>
`values.yaml:` The default configuration values for this chart <br>

### Cleanup the template 

We can delete unwanted files:

* delete everything under /templates, keeping only `_helpers.tpl`
* delete `tests` folder under `templates`

### Add Kubernetes files to our new Chart

Copy your manifest files into `<your-chart-name>/templates/` folder

* `<your-chart-name>/templates/deployment.yaml`
* `<your-chart-name>/templates/service.yaml`
* `<your-chart-name>/templates/configmap.yaml`
* `<your-chart-name>/templates/secret.yaml`

### Helm Lint
To Test Chart syntax, run helm lint

```
helm lint <chart-name>
```


### Test the rendering of our template

```
helm template <Give-your-app-name> <your-chart-name>
```
It will provide you list of list of templates or manfifest file which helm will generate.

## Install our app using our Chart

```
helm install <Give-your-app-name> <your-chart-name>

# list our releases

helm list

# see our deployed components

kubectl get all
kubectl get cm
kubectl get secret
```

## Let's make charts generic.


**Inject your manfifest file vaiable value in values.yaml file**

```
deployment:
  image: "aimvector/python"
  tag: "1.0.4"
```

**Customize your deployment.yaml by providing varibale name to key**
```
image: {{ .Values.deployment.image }}:{{ .Values.deployment.tag }}
```

**Upgrade our prevoius helm release**

```
helm upgrade <Your-App-Name> <Your-chart-name> --values ./you-chart-name/templates/values.yaml
```

**Check revision listt, here revison increased**
  
```
helm list
```

### To make chart more generic.
inject: `"{{ .Values.name }}"` in following manifest files:

* deployment.yaml
* services.yaml
* secret.yaml
* configmap.yaml

`deployment.yaml`
```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: "{{ .Values.name }}"
  labels:
    app: "{{ .Values.name }}"
    test: test
  annotations:
    fluxcd.io/tag.example-app: glob:1.0.*
    fluxcd.io/automated: 'true'
spec:
  selector:
    matchLabels:
      app: "{{ .Values.name }}"
  replicas: 2
  strategy:
    type: RollingUpdate
    rollingUpdate:
      maxSurge: 1
      maxUnavailable: 0
  template:
    metadata:
      annotations:
        checksum/config: {{ include (print $.Template.BasePath "/configmap.yaml") . | sha256sum }}      
      labels:
        app: "{{ .Values.name }}"
    spec:
      containers:
      - name: "{{ .Values.name }}"
        #image: as6779/flux-python:1.0.4
        image: {{ .Values.deployment.image }}:{{ .Values.deployment.tag }}
        imagePullPolicy: Always
        ports:
        - containerPort: 5000
        # livenessProbe:
        #   httpGet:
        #     path: /status
        #     port: 5000
        #   initialDelaySeconds: 3
        #   periodSeconds: 3
        resources:
          requests:
            memory: "64Mi"
            cpu: "50m"
          limits:
            memory: "256Mi"
            cpu: "500m"
      tolerations:
      - key: "cattle.io/os"
        value: "linux"
        effect: "NoSchedule"
#NOTE: comment out `volumeMounts` section for configmap and\or secret guide
        # volumeMounts:
        # - name: secret-volume
        #   mountPath: /secrets/
        # - name: config-volume
        #   mountPath: /configs/
#NOTE: comment out `volumes` section for configmap and\or secret guide
      # volumes:
      # - name: secret-volume
      #   secret:
      #     secretName: mysecret
      # - name: config-volume
      #   configMap:
      #     name: example-config #name of our configmap object

```
`Service.yaml`

```
apiVersion: v1
kind: Service
metadata:
  name: "{{ .Values.name }}"
  labels:
    app: "{{ .Values.name }}"
spec:
  type: NodePort
  selector:
    app: "{{ .Values.name }}"
  ports:
    - protocol: TCP
      name: http
      port: 80
      targetPort: 5000

```

`config-map.yaml`
```
apiVersion: v1
kind: ConfigMap
metadata:
  name: "{{ .Values.name }}"
data:
  config.json: |
    {
      "environment" : "dev3"
    }

```

`secret.yaml`

```
apiVersion: v1
kind: Secret
metadata:
  name: "{{ .Values.name }}"
type: Opaque
stringData:
  secret.json: |-
    {
      "api_key" : "somesecretgoeshere"
    }
```

Now , deploy application

```
helm install <your-new-app-name> <chart-name> --values ./chart-name/custom-values.values.yaml
```

## Trigger deployment change when config changes
Add annotaions in `deployment.yaml`

```
kind: Deployment
spec:
  template:
    metadata:
      annotations:
        checksum/config: {{ include (print $.Template.BasePath "/configmap.yaml") . | sha256sum }}
```

Rollout the change

```
helm upgrade <your-app-name> <your-chart-name> --values <path-of-values-file>
Example:
helm upgrade nginx nginx --values ./example-app/example-app-01.values.yaml
```

***If-Else and Default values***

You can also set default values in case they are not supplied by the `values.yaml` file. <br/>
This may help you keep the `values.yaml` file small <br/>
Here, we will create if else condition to set resoures request and limits in Deployment file.

```
{{- if .Values.deployment.resources }}
  resources:
    {{- if .Values.deployment.resources.requests }}
    requests:
      memory: {{ .Values.deployment.resources.requests.memory | default "50Mi" | quote }}
      cpu: {{ .Values.deployment.resources.requests.cpu | default "10m" | quote }}
    {{- else}}
    requests:
      memory: "50Mi"
      cpu: "10m"
    {{- end}}
    {{- if .Values.deployment.resources.limits }}
    limits:
      memory: {{ .Values.deployment.resources.limits.memory | default "1024Mi" | quote }}
      cpu: {{ .Values.deployment.resources.limits.cpu | default "1" | quote }}
    {{- else}}  
    limits:
      memory: "1024Mi"
      cpu: "1"
    {{- end }}
  {{- else }}
  resources:
    requests:
      memory: "50Mi"
      cpu: "10m"
    limits:
      memory: "1024Mi"
      cpu: "1"
  {{- end}} 
```
<br>

### Rollback the Helm Release

```
helm rollback <your-app-name> <last-release-number>
Example:
helm rollback nginx 1
````

### Uninstall Helm Release

```
helm uninstall <your-app-name>
```
