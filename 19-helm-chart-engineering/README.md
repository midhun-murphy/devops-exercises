# Exercise 19: Helm Chart Engineering

## Objective

Build a reusable Helm chart to deploy an NGINX application with support for multiple environments (Development, QA, and Production). The chart uses configurable values to deploy Kubernetes resources while promoting consistency and reusability.

---

## Features

- Reusable Helm Chart
- Configurable Replica Count
- Resource Requests and Limits
- ConfigMap Support
- Secret Support
- Ingress Support
- Horizontal Pod Autoscaler (HPA)
- Environment-specific Configuration
  - Development
  - QA
  - Production

---

## Project Structure

```text
nginx-app/
├── Chart.yaml
├── values.yaml
├── values-dev.yaml
├── values-qa.yaml
├── values-prod.yaml
├── README.md
├── .helmignore
├── charts/
└── templates/
    ├── _helpers.tpl
    ├── deployment.yaml
    ├── service.yaml
    ├── configmap.yaml
    ├── secret.yaml
    ├── ingress.yaml
    ├── hpa.yaml
    └── NOTES.txt
```

---

## Technologies Used

- Kubernetes
- Helm 3
- Docker
- Kind Cluster
- kubectl

---

## Helm Chart Components

| Component | Description |
|-----------|-------------|
| Deployment | Deploys the NGINX application |
| Service | Exposes the application internally |
| ConfigMap | Stores application configuration |
| Secret | Stores sensitive information |
| Ingress | Exposes the application externally |
| HPA | Automatically scales pods based on CPU usage |

---

## Environment Configuration

### Development

- Replica Count: 1
- ClusterIP Service
- Ingress Disabled
- Autoscaling Disabled

### QA

- Replica Count: 2
- ClusterIP Service
- Ingress Enabled
- Autoscaling Enabled

### Production

- Replica Count: 3
- ClusterIP Service
- Ingress Enabled
- Autoscaling Enabled

---

## Validate the Chart

```bash
helm lint .
```

---

## Render Kubernetes Manifests

### Development

```bash
helm template dev . -f values-dev.yaml
```

### QA

```bash
helm template qa . -f values-qa.yaml
```

### Production

```bash
helm template prod . -f values-prod.yaml
```

---

## Install the Helm Chart

### Development

```bash
helm install dev . -f values-dev.yaml
```

### QA

```bash
helm install qa . -f values-qa.yaml
```

### Production

```bash
helm install prod . -f values-prod.yaml
```

---

## Upgrade the Release

### Development

```bash
helm upgrade dev . -f values-dev.yaml
```

### QA

```bash
helm upgrade qa . -f values-qa.yaml
```

### Production

```bash
helm upgrade prod . -f values-prod.yaml
```

---

## Verify the Deployment

### Check Helm Releases

```bash
helm list
```

### Check Kubernetes Resources

```bash
kubectl get all
```

### Check Deployments

```bash
kubectl get deployment
```

### Check Pods

```bash
kubectl get pods
```

### Check Services

```bash
kubectl get svc
```

### Check ConfigMaps

```bash
kubectl get configmap
```

### Check Secrets

```bash
kubectl get secret
```

### Check Ingress

```bash
kubectl get ingress
```

### Check Horizontal Pod Autoscaler

```bash
kubectl get hpa
```

---

## Uninstall the Releases

```bash
helm uninstall dev
helm uninstall qa
helm uninstall prod
```

# Learning Outcomes
- Learned Helm chart structure and templating.
- Created reusable Kubernetes manifests using Helm.
- Parameterized deployments using values files.
- Managed environment-specific configurations.
- Configured ConfigMaps and Secrets.
- Implemented Ingress for external access.
- Configured Horizontal Pod Autoscaler.
- Validated and deployed Helm releases in multiple environments.

---

## Author

**Midhun Kumar V**