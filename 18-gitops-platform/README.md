# 🚀 Exercise 18 - GitOps Platform Using ArgoCD

## 📌 Objective

The objective of this exercise is to implement a **GitOps deployment platform** using **ArgoCD** on a **Kind Kubernetes Cluster**. Instead of manually deploying Kubernetes resources using `kubectl`, all application manifests are stored in a Git repository. ArgoCD continuously monitors the repository and automatically synchronizes the Kubernetes cluster with the desired state defined in Git.

---

# 🏗️ Architecture

```text
                    Git Commit & Push
                           │
                           ▼
                  GitHub Repository
                           │
                  Watches Repository
                           ▼
                       ArgoCD
                           │
         Auto Sync | Self Heal | Pruning
                           ▼
                 Kubernetes Cluster (Kind)
                           │
                 Namespace (dev)
                           │
                     Deployment
                           │
                     ReplicaSet
                           │
                        Nginx Pods
                           │
                     ClusterIP Service
```

---

# 📁 Repository Structure

```text
18-gitops-platform/
│
├── README.md
│
├── screenshots/
│   ├── argocd-dashboard.png
│   ├── argocd-pods.png
│   ├── auto-sync.png
│   ├── final-kubectl-output.png
│   ├── health-state.png
│   ├── pruning.png
│   ├── repo-connected.png
│   └── self-heal.png
│
└── gitops/
    ├── dev/
    │   ├── namespace.yaml
    │   ├── deployment.yaml
    │   └── service.yaml
    │
    ├── qa/
    │   ├── namespace.yaml
    │   ├── deployment.yaml
    │   └── service.yaml
    │
    └── prod/
        ├── namespace.yaml
        ├── deployment.yaml
        └── service.yaml
```

---

# 🛠️ Prerequisites

- Docker Desktop
- Git
- kubectl
- Kind
- GitHub Account
- ArgoCD

---

# ⚙️ Tools Used

| Tool | Purpose |
|------|---------|
| Kind | Local Kubernetes Cluster |
| Docker Desktop | Container Runtime |
| kubectl | Kubernetes CLI |
| Git | Version Control |
| GitHub | Git Repository |
| ArgoCD | GitOps Continuous Deployment |

---

# 🌍 Environment Structure

| Environment | Namespace | Purpose |
|------------|-----------|---------|
| Dev | dev | Development and testing |
| QA | qa | Quality Assurance testing |
| Production | prod | Live production deployment |

> In this exercise, the **Dev** environment is deployed using ArgoCD. The **QA** and **Production** folders are included to demonstrate a standard multi-environment GitOps repository structure.

---

# 🚀 Implementation Steps

## Step 1 - Create Kind Cluster

```bash
kind create cluster --name gitops
```

Verify

```bash
kubectl get nodes
```

---

## Step 2 - Install ArgoCD

```bash
kubectl create namespace argocd

kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
```

Verify

```bash
kubectl get pods -n argocd
```

---

## Step 3 - Access ArgoCD

```bash
kubectl port-forward svc/argocd-server -n argocd 8090:443
```

Open

```
https://localhost:8090
```

Login

```
Username : admin
Password : Retrieved from argocd-initial-admin-secret
```

---

## Step 4 - Create GitOps Repository

```
gitops/
├── dev
├── qa
└── prod
```

---

## Step 5 - Create Kubernetes Manifests

### namespace.yaml

Creates the Kubernetes Namespace.

### deployment.yaml

Creates

- Nginx Deployment
- ReplicaSet
- Pods

### service.yaml

Creates

- ClusterIP Service

---

## Step 6 - Connect GitHub Repository

Repository

```
https://github.com/midhun-murphy/devops-exercises.git
```

Branch

```
main
```

Path

```
18-gitops-platform/gitops/dev
```

Destination Namespace

```
dev
```

---

## Step 7 - Create ArgoCD Application

Configured

- Repository URL
- Git Branch
- Manifest Path
- Kubernetes Namespace

Enabled

- ✅ Auto Sync
- ✅ Self Heal
- ✅ Pruning

---

# 🔄 GitOps Workflow

```text
Developer
    │
Git Commit
    │
Git Push
    │
GitHub Repository
    │
ArgoCD Detects Changes
    │
Automatic Synchronization
    │
Kubernetes Cluster Updated
```

---

# ✨ Features Demonstrated

## 1. Auto Sync

### Description

Whenever changes are pushed to GitHub, ArgoCD automatically synchronizes the Kubernetes cluster without requiring manual deployment.

### Demonstration

Changed

```yaml
replicas: 2
```

to

```yaml
replicas: 3
```

Git Commands

```bash
git add .
git commit -m "Increase replicas to 3"
git push origin main
```

Result

- Pods automatically increased from **2** to **3**
- No manual `kubectl apply` command was required.

---

## 2. Self Heal

### Description

If a Kubernetes resource is accidentally modified or deleted, Kubernetes and ArgoCD ensure that the desired state is restored.

### Demonstration

Deleted one running Pod.

```bash
kubectl delete pod <pod-name> -n dev
```

Result

- Kubernetes Deployment automatically recreated the Pod.
- The application continued running with the desired number of replicas.

---

## 3. Pruning

### Description

If a resource is removed from Git, ArgoCD automatically removes it from the Kubernetes cluster.

### Demonstration

Deleted

```
service.yaml
```

Git Commands

```bash
git add .
git commit -m "Test pruning"
git push origin main
```

Verification

```bash
kubectl get svc -n dev
```

Output

```
No resources found in dev namespace.
```

Result

The Kubernetes Service was automatically removed because it no longer existed in Git.

The Service was later restored to return the application to its original state.

---

# ✅ Verification Commands

View Nodes

```bash
kubectl get nodes
```

View Namespaces

```bash
kubectl get ns
```

View ArgoCD Pods

```bash
kubectl get pods -n argocd
```

View Application Resources

```bash
kubectl get all -n dev
```

View Services

```bash
kubectl get svc -n dev
```

View Pods

```bash
kubectl get pods -n dev
```

---

# 📸 Screenshots

| Screenshot | Description |
|------------|-------------|
| argocd-dashboard.png | ArgoCD Dashboard |
| argocd-pods.png | ArgoCD Components Running |
| repo-connected.png | GitHub Repository Connected |
| auto-sync.png | Auto Sync Demonstration |
| self-heal.png | Self Heal Demonstration |
| pruning.png | Pruning Demonstration |
| final-kubectl-output.png | Final Kubernetes Resources |
| health-state.png | Healthy and Synced Application |

---

# 📚 Key Learnings

- Understood the GitOps workflow using ArgoCD.
- Learned to deploy Kubernetes applications from GitHub.
- Managed Kubernetes resources using declarative YAML manifests.
- Implemented automatic synchronization with ArgoCD.
- Demonstrated Auto Sync by updating application replicas.
- Demonstrated Self Heal by recovering deleted Pods.
- Demonstrated Pruning by automatically removing deleted resources.
- Learned how Git acts as the single source of truth for Kubernetes deployments.

---

# 🎯 Outcome

Successfully implemented a **GitOps deployment platform** using **Kind Kubernetes**, **GitHub**, and **ArgoCD**.

The platform automatically manages Kubernetes resources using Git while providing:

- ✅ Automatic Synchronization (Auto Sync)
- ✅ Automatic Recovery (Self Heal)
- ✅ Automatic Resource Cleanup (Pruning)

This exercise demonstrates a complete GitOps workflow commonly used in modern cloud-native and production Kubernetes environments.