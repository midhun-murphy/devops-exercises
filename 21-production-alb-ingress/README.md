# Exercise 21: Production Ingress Setup

## 📌 Objective

Configure a production-ready Kubernetes Ingress to expose three different applications using path-based routing.

This project demonstrates how to use the NGINX Ingress Controller to route external traffic to multiple backend services, secure the application using TLS, and implement Kubernetes health checks.

---

## 🏗️ Architecture

```
                        Internet
                            │
                            ▼
                  NGINX Ingress Controller
                            │
      ┌──────────────┬──────────────┬──────────────┐
      │              │              │
      ▼              ▼              ▼
   /api          /admin        /dashboard
      │              │              │
      ▼              ▼              ▼
 API Service    Admin Service   Dashboard Service
      │              │              │
      ▼              ▼              ▼
 Deployment     Deployment      Deployment
```

---

# 📁 Project Structure

```
21-production-alb-ingress/
│
├── screenshots/
│   ├── nginx-controller.png
│   ├── production-resources.png
│   ├── ingress.png
│   ├── ingress-details.png
│   ├── tls-secret.png
│   ├── api-page.png
│   ├── admin-page.png
│   ├── dashboard-page.png
│   └── health-checks.png
│
├── tls/
│   ├── tls.crt
│   └── tls.key
│
├── namespace.yaml
├── api-deployment.yaml
├── api-service.yaml
├── admin-deployment.yaml
├── admin-service.yaml
├── dashboard-deployment.yaml
├── dashboard-service.yaml
├── ingress.yaml
├── .gitignore
└── README.md
```

> **Note:** The `tls/` directory should **not** be committed to GitHub. It contains locally generated self-signed certificates.

---

# 🚀 Features

- Kubernetes Namespace
- Three Independent Deployments
- Three ClusterIP Services
- NGINX Ingress Controller
- Path-Based Routing
- TLS (Self-Signed Certificate)
- HTTP → HTTPS Redirect
- Readiness Probe
- Liveness Probe

---

# 🛠️ Technologies Used

- Kubernetes
- Kind
- NGINX Ingress Controller
- OpenSSL
- YAML
- Docker

---

# 📋 Prerequisites

- Docker
- Kind
- kubectl
- OpenSSL

---

# 🚀 Deployment Steps

## 1. Create Namespace

```bash
kubectl apply -f namespace.yaml
```

---

## 2. Deploy Applications

```bash
kubectl apply -f api-deployment.yaml
kubectl apply -f api-service.yaml

kubectl apply -f admin-deployment.yaml
kubectl apply -f admin-service.yaml

kubectl apply -f dashboard-deployment.yaml
kubectl apply -f dashboard-service.yaml
```

---

## 3. Create TLS Secret

```bash
kubectl create secret tls production-tls \
--cert=tls/tls.crt \
--key=tls/tls.key \
-n production
```

---

## 4. Deploy Ingress

```bash
kubectl apply -f ingress.yaml
```

---

# 🔍 Verification

## Check Pods

```bash
kubectl get pods -n production
```

---

## Check Services

```bash
kubectl get svc -n production
```

---

## Check Ingress

```bash
kubectl get ingress -n production
```

---

## Check TLS Secret

```bash
kubectl get secrets -n production
```

---

## Describe Ingress

```bash
kubectl describe ingress production-ingress -n production
```

---

# 🌐 Access Applications

API

```
https://localhost/api
```

Admin

```
https://localhost/admin
```

Dashboard

```
https://localhost/dashboard
```

---

# ❤️ Health Checks

Each deployment includes:

- Readiness Probe
- Liveness Probe

These probes ensure that:

- Traffic is routed only to healthy pods.
- Unhealthy pods are restarted automatically.

---

# 🎯 Exercise Requirements

| Requirement               | Status |
| ------------------------- | ------ |
| Expose Three Applications | ✅     |
| `/api/*` Route            | ✅     |
| `/admin/*` Route          | ✅     |
| `/dashboard/*` Route      | ✅     |
| NGINX Ingress             | ✅     |
| TLS (HTTPS)               | ✅     |
| HTTP → HTTPS Redirect     | ✅     |
| Health Checks             | ✅     |

---

# 🧹 Cleanup

Delete the application resources:

```bash
kubectl delete -f ingress.yaml
kubectl delete -f dashboard-service.yaml
kubectl delete -f dashboard-deployment.yaml
kubectl delete -f admin-service.yaml
kubectl delete -f admin-deployment.yaml
kubectl delete -f api-service.yaml
kubectl delete -f api-deployment.yaml
kubectl delete -f namespace.yaml
```

Delete the Kind cluster:

```bash
kind delete cluster --name gitops
```

---

# 📚 Key Learnings

- Kubernetes Ingress
- NGINX Ingress Controller
- Path-Based Routing
- TLS Configuration
- Self-Signed Certificates
- HTTP to HTTPS Redirection
- Kubernetes Services
- Deployments
- Readiness Probes
- Liveness Probes

---

## 👨‍💻 Author

**Midhun Kumar V**
