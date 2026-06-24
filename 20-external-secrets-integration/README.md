External Secrets Integration with Amazon EKS
Project Overview

This project demonstrates how to securely manage application secrets in Kubernetes using External Secrets Operator (ESO) and AWS Secrets Manager on an Amazon EKS cluster.

Instead of storing sensitive information directly inside Kubernetes manifests, secrets are stored in AWS Secrets Manager and automatically synchronized into Kubernetes Secrets using External Secrets Operator.

Architecture
AWS Secrets Manager
        │
        ▼
SecretStore
        │
        ▼
External Secret Operator
        │
        ▼
Kubernetes Secret
        │
        ▼
Applications / Pods
Technologies Used
Amazon EKS
Terraform
AWS Secrets Manager
External Secrets Operator
Kubernetes
Helm
AWS CLI
kubectl
Project Structure
20-external-secrets-integration/
│
├── kubernetes/
│   ├── secret-store.yaml
│   └── external-secret.yaml
│
├── terraform/
│   ├── main.tf
│   ├── provider.tf
│   ├── outputs.tf
│   └── versions.tf
│
├── screenshots/
│   ├── eks-cluster.png
│   ├── nodes.png
│   ├── secretstore.png
│   ├── external-secret.png
│   ├── external-secret-pod.png
│   └── secret-created.png
│
├── .gitignore
└── README.md
Infrastructure Provisioning
Deploy EKS Cluster

Initialize Terraform:

terraform init

Validate configuration:

terraform validate

Create infrastructure:

terraform apply -auto-approve
Configure kubectl

Update kubeconfig:

aws eks update-kubeconfig \
--region ap-south-1 \
--name exercise20-eks

Verify cluster access:

kubectl get nodes

Expected Output:

NAME                                        STATUS   ROLES    AGE
ip-10-0-1-123.ap-south-1.compute.internal   Ready    <none>
Install External Secrets Operator

Add Helm Repository:

helm repo add external-secrets https://charts.external-secrets.io

helm repo update

Install External Secrets Operator:

helm install external-secrets external-secrets/external-secrets \
-n external-secrets \
--create-namespace

Verify Installation:

kubectl get pods -n external-secrets

Expected Output:

external-secrets                     Running
external-secrets-cert-controller     Running
external-secrets-webhook             Running
Create AWS Secret

Create secret in AWS Secrets Manager:

{
  "DB_USERNAME": "midhun",
  "DB_PASSWORD": "********",
  "JWT_SECRET": "********"
}

Verify:

aws secretsmanager get-secret-value \
--secret-id app-secrets \
--region ap-south-1
Create Kubernetes SecretStore

Apply SecretStore:

kubectl apply -f kubernetes/secret-store.yaml

Verify:

kubectl get secretstore

Expected Output:

NAME               STATUS   READY
aws-secret-store   Valid    True
Create External Secret

Apply configuration:

kubectl apply -f kubernetes/external-secret.yaml

Verify:

kubectl get externalsecret

Expected Output:

NAME         STATUS         READY
app-secret   SecretSynced   True
Verify Secret Synchronization

Check Kubernetes Secret:

kubectl get secret

Expected Output:

NAME
app-secret

Describe Secret:

kubectl describe secret app-secret

Output:

DB_USERNAME: 6 bytes
DB_PASSWORD: 10 bytes
JWT_SECRET: 17 bytes
Validation
Verify SecretStore
kubectl get secretstore

Output:

aws-secret-store   Valid   True
Verify External Secret
kubectl get externalsecret

Output:

app-secret   SecretSynced   True
Verify Kubernetes Secret
kubectl get secret

Output:

app-secret
Screenshots
EKS Cluster

Worker Node

SecretStore Status

External Secret

External Secrets Pods

Kubernetes Secret Created

Key Learnings
Provisioned Amazon EKS using Terraform.
Installed External Secrets Operator using Helm.
Stored application secrets securely in AWS Secrets Manager.
Created SecretStore for AWS integration.
Created ExternalSecret resources.
Automatically synchronized secrets from AWS Secrets Manager to Kubernetes.
Eliminated hardcoded secrets from Kubernetes manifests.
Improved security and secret lifecycle management.
Cleanup

Delete Kubernetes resources:

kubectl delete -f kubernetes/external-secret.yaml

kubectl delete -f kubernetes/secret-store.yaml

Uninstall External Secrets Operator:

helm uninstall external-secrets -n external-secrets

Destroy Infrastructure:

cd terraform

terraform destroy -auto-approve
Author

Midhun Kumar V
