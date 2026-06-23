# Exercise 17: Implement IRSA for Application Access

## Project Overview

This project demonstrates how to securely grant an application running inside Amazon EKS access to Amazon DynamoDB using **IAM Roles for Service Accounts (IRSA)** without storing AWS Access Keys inside containers.

The application performs the following DynamoDB operations:

- PutItem
- GetItem
- UpdateItem

Authentication is handled through:

- IAM Policy
- IAM Role
- OIDC Provider
- Kubernetes Service Account
- IRSA (IAM Roles for Service Accounts)

---

## Architecture

```text
+------------------------+
|   EKS Pod              |
|  (Python Application)  |
+-----------+------------+
            |
            v
+------------------------+
| Kubernetes Service     |
| Account (dynamodb-sa)  |
+-----------+------------+
            |
            v
+------------------------+
| IAM Role (IRSA)        |
+-----------+------------+
            |
            v
+------------------------+
| AWS STS                |
| AssumeRoleWithWebIdentity
+-----------+------------+
            |
            v
+------------------------+
| DynamoDB Table         |
| irsa-demo-table        |
+------------------------+
```

---

## Technologies Used

- AWS EKS
- Terraform
- DynamoDB
- IAM
- IRSA
- OIDC Provider
- Docker
- Amazon ECR
- Kubernetes
- Python
- Boto3

---

## Project Structure

```text
17-irsa-dynamodb-access
│
├── app
│   ├── app.py
│   ├── Dockerfile
│   └── requirements.txt
│
├── kubernetes
│   ├── deployment.yaml
│   └── service-account.yaml
│
├── terraform
│   ├── provider.tf
│   ├── versions.tf
│   ├── variables.tf
│   ├── vpc.tf
│   ├── eks.tf
│   ├── iam.tf
│   ├── dynamodb.tf
│   └── outputs.tf
│
├── screenshots
│
└── README.md
```

---

## Infrastructure Created

Terraform provisions:

### Networking

- VPC
- Internet Gateway
- Public Route Table
- 2 Public Subnets

### Amazon EKS

- EKS Cluster
- Managed Node Group
- CoreDNS Add-on
- kube-proxy Add-on
- VPC CNI Add-on

### Security

- IAM Policy
- IAM Role
- OIDC Provider
- IRSA Configuration

### Database

- DynamoDB Table

---

## DynamoDB Table

Table Name:

```text
irsa-demo-table
```

Primary Key:

```text
id (String)
```

---

## IAM Permissions

The application is allowed to perform:

```json
{
  "Action": [
    "dynamodb:GetItem",
    "dynamodb:PutItem",
    "dynamodb:UpdateItem"
  ]
}
```

---

## Containerization

Build Docker Image:

```bash
docker build -t irsa-dynamodb-app ./app
```

Tag Image:

```bash
docker tag irsa-dynamodb-app:latest <ACCOUNT_ID>.dkr.ecr.ap-south-1.amazonaws.com/irsa-dynamodb-app:latest
```

Push Image:

```bash
docker push <ACCOUNT_ID>.dkr.ecr.ap-south-1.amazonaws.com/irsa-dynamodb-app:latest
```

---

## Deploy Application

Create Service Account:

```bash
kubectl apply -f kubernetes/service-account.yaml
```

Deploy Application:

```bash
kubectl apply -f kubernetes/deployment.yaml
```

Verify:

```bash
kubectl get pods
```

Expected:

```text
NAME                            READY   STATUS
dynamodb-app-xxxxxxxxxx         1/1     Running
```

---

## IRSA Verification

Verify Service Account:

```bash
kubectl describe sa dynamodb-sa
```

Expected:

```text
eks.amazonaws.com/role-arn
```

Verify Pod Environment:

```bash
kubectl describe pod <pod-name>
```

Expected:

```text
AWS_ROLE_ARN
AWS_WEB_IDENTITY_TOKEN_FILE
```

No AWS access keys are stored inside the pod.

---

## Application Output

```text
=== PutItem ===
Item inserted

=== GetItem ===
{'course': 'DevOps', 'id': '1001', 'name': 'Midhun'}

=== UpdateItem ===
Item updated
```

---

## DynamoDB Verification

```bash
aws dynamodb scan \
--table-name irsa-demo-table \
--region ap-south-1
```

Output:

```json
{
  "Items": [
    {
      "id": {
        "S": "1001"
      },
      "course": {
        "S": "AWS DevOps"
      },
      "name": {
        "S": "Midhun"
      }
    }
  ]
}
```

---

## Screenshots

Add screenshots to the `screenshots` folder.

### Recommended Screenshots

1. Terraform Apply Success
2. EKS Cluster Active
3. Worker Nodes Ready
4. OIDC Provider
5. IAM Role
6. DynamoDB Table
7. Service Account
8. ECR Repository
9. ECR Image
10. Pod Running
11. IRSA Environment Variables
12. Application Output
13. DynamoDB Scan Result

---

## Key Learning Outcomes

- Implemented IAM Roles for Service Accounts (IRSA)
- Eliminated use of AWS Access Keys inside containers
- Configured OIDC Provider for EKS
- Built and deployed Docker containers to Amazon ECR
- Deployed applications on Amazon EKS
- Integrated Kubernetes workloads with DynamoDB securely
- Followed AWS security best practices using least privilege access

---

## Outcome

Successfully implemented secure DynamoDB access from an EKS application using IRSA.

### Operations Verified

- PutItem ✅
- GetItem ✅
- UpdateItem ✅

### Security Verified

- No AWS Access Keys Used ✅
- IAM Role Authentication via IRSA ✅
- Least Privilege Access Control ✅