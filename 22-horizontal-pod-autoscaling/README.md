# Exercise 22: Horizontal Pod Autoscaling (HPA) using Kind

## 📌 Overview

This project demonstrates **Horizontal Pod Autoscaling (HPA)** in Kubernetes using a local **Kind (Kubernetes in Docker)** cluster.

The application automatically scales based on CPU utilization with the help of **Metrics Server**. Load is generated using a BusyBox container, allowing Kubernetes to increase the number of application pods when CPU usage exceeds the configured threshold.

> **Note:** Cluster Autoscaler (Node Autoscaling) cannot be demonstrated on Kind because Kind runs Kubernetes nodes as Docker containers. Automatic node scaling requires cloud-managed Kubernetes services such as **Amazon EKS**, **Google GKE**, or **Azure AKS**.

---

## 🎯 Objective

- Deploy an application on Kubernetes
- Install Metrics Server
- Configure CPU requests and limits
- Create a Horizontal Pod Autoscaler
- Generate application load
- Observe automatic pod scaling

---

## 🏗️ Architecture

```text
                    +----------------+
                    | Load Generator |
                    +-------+--------+
                            |
                            v
                   +------------------+
                   | Kubernetes Service|
                   +---------+--------+
                             |
                             v
                +-------------------------+
                | Deployment (php-apache) |
                +-------------------------+
                       |            |
                  Pod 1 ...      Pod N
                       |
                       v
          Horizontal Pod Autoscaler (HPA)
                       |
              CPU Utilization > 50%
                       |
                Scale Pods Automatically

            Metrics Server provides CPU metrics
```

---

## 🛠️ Technologies Used

- Kubernetes
- Kind
- Metrics Server
- Horizontal Pod Autoscaler (HPA)
- BusyBox
- kubectl

---

## 📂 Project Structure

```text
22-horizontal-pod-autoscaling/
│
├── screenshots/
│   ├── deployment.png
│   ├── hpa-created.png
│   ├── hpa-events.png
│   ├── kind-cluster.png
│   ├── load-generator.png
│   ├── metrics-server.png
│   ├── pod-metrics.png
│   └── pod-scaling.png
│
├── kind-config.yaml
├── namespace.yaml
├── deployment.yaml
├── service.yaml
├── hpa.yaml
├── README.md
└── .gitignore
```

---

## 📋 Prerequisites

- Docker Desktop
- Kind
- kubectl

Verify the installation:

```bash
docker --version
kind --version
kubectl version --client
```

---

## 🚀 Step 1: Create Kind Cluster

```bash
kind create cluster --name autoscaling --config kind-config.yaml
```

Verify:

```bash
kubectl get nodes
```

Expected Output:

```text
autoscaling-control-plane
autoscaling-worker
autoscaling-worker2
autoscaling-worker3
```

---

## 🚀 Step 2: Install Metrics Server

```bash
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/download/v0.7.2/components.yaml
```

Verify:

```bash
kubectl top nodes
```

---

## 🚀 Step 3: Create Namespace

```bash
kubectl apply -f namespace.yaml
```

---

## 🚀 Step 4: Deploy Application

```bash
kubectl apply -f deployment.yaml
```

Verify:

```bash
kubectl get deployment -n autoscaling
kubectl get pods -n autoscaling
```

---

## 🚀 Step 5: Create Service

```bash
kubectl apply -f service.yaml
```

Verify:

```bash
kubectl get svc -n autoscaling
```

---

## 🚀 Step 6: Create Horizontal Pod Autoscaler

```bash
kubectl apply -f hpa.yaml
```

Verify:

```bash
kubectl get hpa -n autoscaling
```

Example:

```text
NAME         REFERENCE               TARGETS
php-apache   Deployment/php-apache   cpu:10%/50%
```

---

## 🚀 Step 7: Generate Load

Create a BusyBox load generator:

```bash
kubectl run -i --tty load-generator \
--rm \
--restart=Never \
--image=busybox:1.36 \
-n autoscaling -- sh
```

Inside the BusyBox shell:

```sh
while true; do
  wget -q -O- http://php-apache;
done
```

This continuously sends requests to the application.

---

## 📊 Step 8: Observe Autoscaling

Watch the HPA:

```bash
kubectl get hpa -n autoscaling -w
```

Watch the pods:

```bash
kubectl get pods -n autoscaling -w
```

Monitor CPU usage:

```bash
kubectl top pods -n autoscaling
```

---

# ✅ Validation Commands

### Cluster

```bash
kubectl get nodes
```

### Metrics

```bash
kubectl top nodes
```

### Deployment

```bash
kubectl get deployment -n autoscaling
```

### Pods

```bash
kubectl get pods -n autoscaling
```

### Service

```bash
kubectl get svc -n autoscaling
```

### Horizontal Pod Autoscaler

```bash
kubectl get hpa -n autoscaling
```

### CPU Metrics

```bash
kubectl top pods -n autoscaling
```

### HPA Details

```bash
kubectl describe hpa php-apache -n autoscaling
```

---

# 📈 Results

The Horizontal Pod Autoscaler successfully scaled the application based on CPU utilization.

Observed scaling:

```text
Pods

2
↓
3
↓
6
↓
7
↓
8
```

The HPA automatically increased the number of pods when CPU utilization exceeded the configured threshold.

---

# ⚠️ Kind Limitation

This project demonstrates **Horizontal Pod Autoscaling (HPA)**.

The exercise also expects **Cluster Autoscaler** (Node Autoscaling).

Node autoscaling cannot be demonstrated on Kind because:

- Kind nodes run as Docker containers.
- Kind cannot automatically provision additional worker nodes.
- Cluster Autoscaler requires cloud-managed Kubernetes platforms such as Amazon EKS, Google GKE, or Azure AKS.

---

# 🧹 Cleanup

Delete the application resources:

```bash
kubectl delete -f hpa.yaml
kubectl delete -f service.yaml
kubectl delete -f deployment.yaml
kubectl delete -f namespace.yaml
```

Delete the Kind cluster:

```bash
kind delete cluster --name autoscaling
```

---

# 📚 Learning Outcomes

After completing this exercise, you will understand:

- Horizontal Pod Autoscaler (HPA)
- Metrics Server
- CPU-based autoscaling
- Resource requests and limits
- Kubernetes Services
- Load testing inside Kubernetes
- Monitoring pod CPU utilization
- Difference between HPA and Cluster Autoscaler
- Limitations of running autoscaling on Kind

---

# ✅ Exercise Status

| Requirement               | Status                   |
| ------------------------- | ------------------------ |
| Kind Cluster              | ✅ Completed             |
| Metrics Server            | ✅ Completed             |
| Namespace                 | ✅ Completed             |
| Deployment                | ✅ Completed             |
| Service                   | ✅ Completed             |
| Horizontal Pod Autoscaler | ✅ Completed             |
| CPU Metrics               | ✅ Completed             |
| Load Generator            | ✅ Completed             |
| Pod Autoscaling           | ✅ Completed             |
| Cluster Autoscaler        | ⚠️ Not Supported on Kind |
