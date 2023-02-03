# How to achive Persistant Volume now in EKS ?
We can use the Amazon EBS CSI driver to run EBS volumes as K8s PVs. When the driver is deployed, any application that creates a PV in the cluster, results in Amazon automatically creating EBS volumes in the underlying infrastructure.
<br>
#### Let's start configuring AWS EBS CSI in EKS

* **Create IAM Policy and Role** <br>
To use AWS EBS as PV, we need to first create an IAM policy to enable the CSI driver to access the AWS API. 
Let’s create an IAM role and attach the required AWS managed policy i.e `AmazonEBSCSIDriverPolicy` with the following command. <br>

```
eksctl utils associate-iam-oidc-provider --region=us-east-2 --cluster=dev-cluster --approve
```

```
eksctl create iamserviceaccount \
  --name ebs-csi-controller-sa \
  --namespace kube-system \
  --cluster dev-cluster \
  --region us-east-2 \
  --attach-policy-arn arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy \
  --approve \
  --role-only \
  --role-name AmazonEKS_EBS_CSI_DriverRole
```
 ***Above command deploys an AWS CloudFormation stack that creates an IAM role, attaches the IAM policy to it, and annotates the existing ebs-csi-controller-sa service account with the Amazon Resource Name (ARN) of the IAM role.***

<br>

* **Add AWS EBS CSI Driver to Add-on**
```
eksctl create addon --name aws-ebs-csi-driver --cluster dev-cluster --service-account-role-arn 
```

## Test EBS CSI Driver
-  First let’s create a `StorageClass` so we can do dynamic provisioning:
```
# storage_class_test.yml
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: ebs-sc
provisioner: ebs.csi.aws.com
parameters:
  type: gp3
  encrypted: 'true'
volumeBindingMode: WaitForFirstConsumer
```
- Then we create a persistant volume claim, which will create pv.

```
# claim_test.yml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: ebs-claim
spec:
  accessModes:
    - ReadWriteOnce
  storageClassName: ebs-sc
  resources:
    requests:
      storage: 4Gi
```

- Finally let’s create the Pod:

```
# app_test.yml
apiVersion: v1
kind: Pod
metadata:
  name: app
spec:
  containers:
  - name: app
    image: centos
    command: ["/bin/sh"]
    args: ["-c", "while true; do echo $(date -u) >> /data/out.txt; sleep 5; done"]
    volumeMounts:
    - name: persistent-storage
      mountPath: /data
  volumes:
  - name: persistent-storage
    persistentVolumeClaim:
      claimName: ebs-claim
```

- Finally apply all the manifest yaml files

```
kubectl create -f storage_class_test.yml
kubectl create -f claim_test.yml
kubectl create -f app_test.yml
```
<br>
Let's check status of pv and pvc

```
$ kubectl get storageclass ebs-sc
NAME     PROVISIONER       RECLAIMPOLICY   VOLUMEBINDINGMODE      ALLOWVOLUMEEXPANSION   AGE
ebs-sc   ebs.csi.aws.com   Delete          WaitForFirstConsumer   false                  14m
$ kubectl get pv
NAME                                       CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS   CLAIM               STORAGECLASS   REASON   AGE
pvc-ef7e09e2-60ff-4ed5-8f20-4f4e24816e16   4Gi        RWO            Delete           Bound    default/ebs-claim   ebs-sc                  14m
$ kubectl get pvc
NAME        STATUS   VOLUME                                     CAPACITY   ACCESS MODES   STORAGECLASS   AGE
ebs-claim   Bound    pvc-ef7e09e2-60ff-4ed5-8f20-4f4e24816e16   4Gi        RWO            ebs-sc         14m
```

And Pod status
```
kubectl get po app
NAME   READY   STATUS    RESTARTS   AGE
app    1/1     Running   0          15m
```

Now if you delete the Pod, the PVC will still exist and when you recreate the Pod, it will automatically reattach the PVC.
<br>
Even the new Pod is scheduled to a different node, its data still persists.

**Refrences** <br>
[Medium Blog](https://blog.devgenius.io/k8s-using-aws-ebs-as-persistent-volume-dcf4e50fb755)






