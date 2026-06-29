# Exercise 6 – EKS Node Scale Failure (Kind Simulation)

## Overview

This exercise demonstrates a Kubernetes node scaling failure scenario using a Kind cluster. The objective is to simulate an application that cannot scale because the cluster runs out of CPU resources. Some Pods remain in the **Pending** state due to insufficient CPU, and no Cluster Autoscaler is available to add additional worker nodes.

---

## Objective

- Deploy an application with high CPU requests.
- Scale the deployment to multiple replicas.
- Observe Pods entering the **Pending** state.
- Investigate the scheduling failure.
- Identify whether the issue is related to:
  - Horizontal Pod Autoscaler (HPA)
  - Worker Nodes
  - Cluster Autoscaler

---

## Project Structure

```
6-node-scale-failure/
│
├── manifests/
│   ├── namespace.yaml
│   └── deployment.yaml
│
├── screenshots/
│   ├── cluster-nodes.png
│   ├── pods-pending.png
│   ├── failed-scheduling.png
│   ├── node-resources.png
│   └── no-cluster-autoscaler.png
│
├── kind-config.yaml
├── README.md
└── .gitignore
```

---

## Prerequisites

- Docker Desktop
- Kind
- kubectl

Verify installation:

```bash
docker --version
kind version
kubectl version --client
```

---

## Create the Kind Cluster

```bash
kind create cluster --name scale-lab --config kind-config.yaml
```

Verify the cluster:

```bash
kubectl get nodes
```

---

## Deploy the Application

Create the namespace:

```bash
kubectl apply -f manifests/namespace.yaml
```

Deploy the application:

```bash
kubectl apply -f manifests/deployment.yaml
```

Verify the Pods:

```bash
kubectl get pods -n scaling
```

---

## Simulate Scaling Failure

Scale the deployment:

```bash
kubectl scale deployment cpu-demo --replicas=15 -n scaling
```

Monitor the Pods:

```bash
kubectl get pods -n scaling -w
```

Some Pods should remain in the **Pending** state because the cluster does not have enough CPU resources.

---

## Troubleshooting Commands

### Check Cluster Nodes

```bash
kubectl get nodes
```

### Check Running and Pending Pods

```bash
kubectl get pods -n scaling
```

### Investigate a Pending Pod

```bash
kubectl describe pod <pending-pod-name> -n scaling
```

Example:

```bash
kubectl describe pod cpu-demo-6c46c68cd4-hvhf5 -n scaling
```

Expected Event:

```
Warning  FailedScheduling
0/4 nodes are available:
3 Insufficient cpu
```

---

### Inspect Node Resources

```bash
kubectl describe node scale-lab-worker
```

Review the **Allocated resources** section.

---

### Verify Cluster Autoscaler

```bash
kubectl get deployment -n kube-system
```

There is no Cluster Autoscaler deployment in the Kind cluster.

---

## Root Cause Analysis

### HPA Issue

**No**

The deployment was successfully scaled (manually for this simulation). The scaling request itself was not the problem.

### Node Issue

**Yes**

The worker nodes exhausted their available CPU resources. Kubernetes could not schedule all requested Pods.

Evidence:

- Pods remained in the **Pending** state.
- Scheduler reported **Insufficient cpu**.

### Cluster Autoscaler Issue

**Yes**

The Kind cluster does not include a Cluster Autoscaler.

As a result:

- No additional worker nodes were created.
- Pending Pods remained unscheduled.

---

## Learning Outcomes

- Understood Kubernetes scheduling behavior.
- Identified Pending Pods caused by insufficient CPU.
- Investigated scheduling failures using `kubectl describe`.
- Examined node resource allocation.
- Understood the role of Cluster Autoscaler in scaling worker nodes.

---

## Cleanup

Delete the deployment:

```bash
kubectl delete -f manifests/deployment.yaml
```

Delete the namespace:

```bash
kubectl delete -f manifests/namespace.yaml
```

Delete the Kind cluster:

```bash
kind delete cluster --name scale-lab
```

---

## Conclusion

This exercise successfully simulated a node scaling failure in Kubernetes. The investigation showed that Pods remained in the **Pending** state because worker nodes had insufficient CPU resources. Since no Cluster Autoscaler was available, the cluster could not provision additional nodes, preventing the application from scaling successfully.