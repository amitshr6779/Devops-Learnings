## Set Enviroment variables
```
export KARPENTER_VERSION=v0.22.1
export CLUSTER_NAME="terraformeks"
export AWS_DEFAULT_REGION="ap-south-1"
export AWS_ACCOUNT_ID="$(aws sts get-caller-identity --query Account --output text)"
export CLUSTER_ENDPOINT="$(aws eks describe-cluster --name ${CLUSTER_NAME} --query "cluster.endpoint" --output text)"
```
## Create IAM OIDC Provider
Check if IAM identinty provider is already exist for you cluster [here](https://us-east-1.console.aws.amazon.com/iamv2/home?region=ap-south-1#/identity_providers), if not create one IAM OIDC.

```
eksctl utils associate-iam-oidc-provider --region=ap-south-1 --cluster=terraformeks --approve
```

## Create the Karpenter Infrastructure and IAM Roles 

```
TEMPOUT=$(mktemp)

curl -fsSL https://karpenter.sh/"${KARPENTER_VERSION}"/getting-started/getting-started-with-eksctl/cloudformation.yaml  > $TEMPOUT \
&& aws cloudformation deploy \
  --stack-name "Karpenter-${CLUSTER_NAME}" \
  --template-file "${TEMPOUT}" \
  --capabilities CAPABILITY_NAMED_IAM \
  --parameter-overrides "ClusterName=${CLUSTER_NAME}"
```
## Grant Access to Nodes to Join the Cluster

```
eksctl create iamidentitymapping \
  --username system:node:{{EC2PrivateDNSName}} \
  --cluster "${CLUSTER_NAME}" \
  --arn "arn:aws:iam::${AWS_ACCOUNT_ID}:role/KarpenterNodeRole-${CLUSTER_NAME}" \
  --group system:bootstrappers \
  --group system:nodes
```

## Create the KarpenterController IAM Role 
```
eksctl create iamserviceaccount \
  --cluster "${CLUSTER_NAME}" --name karpenter --namespace karpenter \
  --role-name "${CLUSTER_NAME}-karpenter" \
  --attach-policy-arn "arn:aws:iam::${AWS_ACCOUNT_ID}:policy/KarpenterControllerPolicy-${CLUSTER_NAME}" \
  --role-only \
  --approve

export KARPENTER_IAM_ROLE_ARN="arn:aws:iam::${AWS_ACCOUNT_ID}:role/${CLUSTER_NAME}-karpenter"
```
- Note: if role already exist delete it through clodformation  and redeploy above command.

## Install Karpenter in cluster uisng  Helm Chart 

```
helm upgrade --install karpenter oci://public.ecr.aws/karpenter/karpenter --version ${KARPENTER_VERSION} --namespace karpenter --create-namespace \
  --set serviceAccount.annotations."eks\.amazonaws\.com/role-arn"=${KARPENTER_IAM_ROLE_ARN} \
  --set settings.aws.clusterName=${CLUSTER_NAME} \
  --set settings.aws.clusterEndpoint=${CLUSTER_ENDPOINT} \
  --set settings.aws.defaultInstanceProfile=KarpenterNodeInstanceProfile-${CLUSTER_NAME} \
  --set settings.aws.interruptionQueueName=${CLUSTER_NAME} \
  --wait
```
## Apply Provisoner
A single Karpenter provisioner is capable of handling many different pod shapes. Karpenter makes scheduling and provisioning decisions based on pod attributes such as labels and affinity. In other words, Karpenter eliminates the need to manage many different node groups.


```
---
apiVersion: karpenter.sh/v1alpha5
kind: Provisioner
metadata:
  name: default
spec:
  requirements:
    - key: node.kubernetes.io/instance-type # If not included, all instance types are considered
      operator: In
      values: ["t2.micro", "t2.medium"]
    - key: "kubernetes.io/arch"
      operator: In
      values: ["arm64"]
    - key: karpenter.sh/capacity-type
      operator: In
      values: ["spot"]
  limits:
    resources:
      cpu: 1000
  provider:
    subnetSelector:
      karpenter.sh/discovery: terraformeks
    securityGroupSelector:
      karpenter.sh/discovery: terraformeks
    instanceProfile: KarpenterNodeInstanceProfile-terraformeks
  ttlSecondsAfterEmpty: 30
```

* Note make sure to tag subnet and security group with key value mentioned in proviosner.

## Let's Test Automatic Node Provisioning 

```
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: inflate
spec:
  replicas: 0
  selector:
    matchLabels:
      app: inflate
  template:
    metadata:
      labels:
        app: inflate
    spec:
      terminationGracePeriodSeconds: 0
      containers:
        - name: inflate
          image: public.ecr.aws/eks-distro/kubernetes/pause:3.2
          resources:
            requests:
              cpu: 1
```
```
kubectl apply -f deployment.yaml
kubectl scale deployment inflate --replicas 5
kubectl logs -f -n karpenter -l app.kubernetes.io/name=karpenter -c controller
```

**Refrences**
1. [Hashnode Blog](https://makendran.hashnode.dev/just-in-time-worker-nodes-with-karpenter)
2. [Karpenter](https://karpenter.sh/v0.22.1/getting-started/getting-started-with-eksctl/)
3. [Karpenter by AWS](https://aws.amazon.com/premiumsupport/knowledge-center/eks-install-karpenter/)
