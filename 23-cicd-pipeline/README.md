# 🚀 Exercise 23 – CI/CD Pipeline with GitHub Actions, Amazon ECR & ArgoCD

## 📌 Objective

Build an end-to-end CI/CD pipeline that automatically:

- Runs unit tests
- Performs Docker image security scanning using Trivy
- Builds a Docker image
- Pushes the image to Amazon ECR
- Updates Kubernetes deployment manifests
- Automatically deploys the latest version using ArgoCD (GitOps)

---

# 🏗️ Architecture

```text
Developer
    │
    ▼
GitHub Repository
    │
    ▼
GitHub Actions
 ├── Test
 ├── Security Scan
 ├── Build Docker Image
 ├── Push Docker Image to Amazon ECR
 └── Update Kubernetes Manifest
            │
            ▼
GitHub Repository
            │
            ▼
ArgoCD
            │
            ▼
Kind Kubernetes Cluster
            │
            ▼
Calculator Application
```

---

# 🛠️ Technologies Used

- Python
- Flask
- Pytest
- Docker
- GitHub Actions
- Trivy
- Amazon ECR
- Kubernetes
- Kind
- ArgoCD
- Git

---

# 📁 Project Structure

```
23-cicd-pipeline/
│
├── .github/
│   └── workflows/
│       └── cicd.yml
│
├── k8s/
│   ├── namespace.yaml
│   ├── deployment.yaml
│   └── service.yaml
│
├── tests/
│   └── test_app.py
│
├── app.py
├── calculator.py
├── requirements.txt
├── Dockerfile
├── pytest.ini
└── README.md
```

---

# ⚙️ Prerequisites

Install the following:

- Git
- Docker Desktop
- Python 3.12
- kubectl
- Kind
- AWS CLI
- GitHub Account
- Amazon ECR Repository

---

# 🔐 GitHub Secrets

Configure the following repository secrets.

| Secret | Description |
|---------|-------------|
| AWS_ACCESS_KEY_ID | AWS Access Key |
| AWS_SECRET_ACCESS_KEY | AWS Secret Key |
| AWS_REGION | AWS Region |
| AWS_ACCOUNT_ID | AWS Account ID |
| ECR_REPOSITORY | Amazon ECR Repository |

---

# 🚀 Workflow

## Stage 1 – Test

- Checkout Repository
- Setup Python
- Install Dependencies
- Run Unit Tests using Pytest

---

## Stage 2 – Security Scan

- Install Trivy
- Scan Docker Image
- Fail workflow on HIGH or CRITICAL vulnerabilities

---

## Stage 3 – Build

- Build Docker Image

---

## Stage 4 – Push

- Configure AWS Credentials
- Login to Amazon ECR
- Tag Docker Image
- Push Docker Image to Amazon ECR

---

## Stage 5 – Deploy

- Update Kubernetes Deployment Manifest
- Commit Updated Manifest
- Push Changes to GitHub
- ArgoCD Automatically Syncs Changes
- Kubernetes Deploys Latest Image

---

# ☸️ Kubernetes Resources

The deployment creates:

- Namespace
- Deployment
- Service

Deployment configuration:

- Replicas: 2
- Container Port: 5000
- Image stored in Amazon ECR

---

# 🔄 ArgoCD Configuration

Enabled Features:

- Auto Sync
- Self Heal
- Automatic Pruning
- GitOps Deployment

---

# 📋 Verification Commands

### GitHub Actions

Verify workflow execution.

```bash
GitHub → Actions
```

---

### Kubernetes

List all resources.

```bash
kubectl get all -n calculator
```

List running pods.

```bash
kubectl get pods -n calculator
```

Check deployment.

```bash
kubectl get deployment -n calculator
```

Verify rollout.

```bash
kubectl rollout status deployment/calculator -n calculator
```

---

### ArgoCD

Check application.

```bash
kubectl get applications -n argocd
```

Describe application.

```bash
kubectl describe application calculator -n argocd
```

---

# 📷 Screenshots

Include the following screenshots in the report.

## 1. Project Structure

- VS Code project structure

---

## 2. GitHub Repository

- Repository home page

---

## 3. GitHub Actions Pipeline

Show completed workflow:

- ✅ Test
- ✅ Security Scan
- ✅ Build
- ✅ Push
- ✅ Deploy

---

## 4. Test Job

Show successful unit tests.

---

## 5. Security Scan

Show Trivy scan completed.

---

## 6. Build Job

Show Docker image build completed.

---

## 7. Push Job

Show successful push to Amazon ECR.

---

## 8. Deploy Job

Show manifest update and deployment.

---

## 9. Amazon ECR

Repository with pushed Docker image.

---

## 10. Kubernetes Resources

```bash
kubectl get all -n calculator
```

---

## 11. Running Pods

```bash
kubectl get pods -n calculator
```

---

## 12. Deployment

```bash
kubectl get deployment -n calculator
```

---

## 13. ArgoCD Dashboard

Show:

- Calculator Application
- Sync Status
- Health Status
- Resource Tree

---

## 14. ArgoCD Sync History

Show successful synchronization.

---

## 15. Application Output

Show Calculator API running through port forwarding.

---

# 🎯 Expected Output

GitHub Actions

- Test Passed
- Security Scan Passed
- Build Passed
- Push Passed
- Deploy Passed

Amazon ECR

- Docker image successfully pushed

Kubernetes

- Deployment created
- Pods running
- Service created

ArgoCD

- Application synchronized
- Automatic deployment completed

---

# 📚 Learning Outcomes

After completing this exercise, you learned how to:

- Build a complete CI/CD pipeline using GitHub Actions
- Execute automated unit testing with Pytest
- Scan Docker images using Trivy
- Build and tag Docker images
- Push Docker images to Amazon ECR
- Deploy applications on Kubernetes
- Implement GitOps using ArgoCD
- Automate deployments with Kubernetes manifests
- Integrate GitHub Actions, Amazon ECR, and ArgoCD
- Create a production-style DevOps deployment workflow

---

# ✅ Conclusion

Successfully implemented a complete CI/CD pipeline that automates testing, security scanning, Docker image creation, image publishing to Amazon ECR, Kubernetes manifest updates, and GitOps-based deployment using ArgoCD. Every code change triggers an automated workflow, ensuring reliable, repeatable, and production-ready application delivery.