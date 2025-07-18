# K8s Homelab with k0s and Flux

This repository contains configuration for a Kubernetes homelab using k0s and Flux for GitOps.

## Prerequisites

- k0s binary installed
- kubectl installed
- flux CLI installed
- Git repository access

## Setup Instructions

### 1. Install k0s Cluster

```bash
# Install k0s with the provided configuration
sudo k0s install controller --config k0s.yaml
sudo k0s start
```

### 2. Get kubeconfig

```bash
# Get admin kubeconfig
sudo k0s kubeconfig admin > ~/.kube/config
```

### 3. Bootstrap Flux

```bash
# Check cluster is ready
kubectl get nodes

# Bootstrap Flux (replace with your GitHub token)
export GITHUB_TOKEN=<your-github-token>
flux bootstrap github \
  --owner=304442 \
  --repository=k8s-homelab \
  --branch=main \
  --path=./clusters/k0s-homelab \
  --personal
```

### 4. Verify Installation

```bash
# Check Flux components
flux get kustomizations

# Check installed applications
kubectl get pods -A
```

## Repository Structure

```
├── clusters/
│   └── k0s-homelab/           # Cluster-specific configurations
│       ├── flux-system/       # Flux system components (auto-generated)
│       ├── infrastructure.yaml # Infrastructure kustomization
│       └── apps.yaml          # Applications kustomization
├── infrastructure/            # Infrastructure components
│   ├── sources/               # Git repositories, Helm repos
│   ├── controllers/           # Controllers (Weave GitOps, etc.)
│   ├── networking/            # Networking components
│   └── monitoring/            # Monitoring stack
├── apps/                      # Application manifests
│   ├── base/                  # Base configurations
│   ├── production/            # Production overlays
│   └── staging/               # Staging overlays
└── k0s.yaml                   # k0s cluster configuration
```

## Applications Included

- **Weave GitOps**: Web UI for Flux (http://localhost:9001 after port-forward)
- **Podinfo**: Sample application for testing
- **NGINX Ingress**: Pre-configured in k0s.yaml
- **cert-manager**: Pre-configured in k0s.yaml

## Managing Applications

To add new applications:

1. Create manifests in `apps/base/`
2. Add overlays in `apps/production/` or `apps/staging/`
3. Update kustomization.yaml files
4. Commit and push - Flux will automatically deploy

## Accessing Weave GitOps

```bash
# Port forward to access UI
kubectl port-forward -n flux-system svc/weave-gitops 9001:9001

# Get admin password
kubectl get secret -n flux-system weave-gitops-admin-user -o jsonpath='{.data.password}' | base64 -d
```

## Troubleshooting

```bash
# Check Flux status
flux get all

# Check reconciliation
flux get kustomizations

# Force reconciliation
flux reconcile kustomization flux-system
```