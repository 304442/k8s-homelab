# k8s-homelab Ansible Deployment

Simple, reliable Ansible automation for complete k8s-homelab deployment.

## What This Does

🎯 **Complete Infrastructure Setup:**
- Installs k0s Kubernetes cluster
- Configures MetalLB load balancer
- Deploys Immich photo management
- Sets up PostgreSQL with vector support
- Configures Redis caching
- Enables machine learning features
- Creates admin user automatically
- Installs kubectl and k9s management tools
- Sets up useful kubectl aliases

## Requirements

- Ansible installed locally
- SSH access to target server
- Ubuntu/Debian target system

## Quick Start

1. **Update inventory** (if needed):
   ```bash
   # Edit ansible/inventory.yml with your server details
   vim inventory.yml
   ```

2. **Deploy everything**:
   ```bash
   ansible-playbook site.yml
   ```

3. **Access Immich**:
   - URL: http://immich.07c.me
   - Username: admin@07c.me
   - Password: admin123

## Configuration

All settings are in `inventory.yml`:

```yaml
# Domain settings
domain: 07c.me
immich_domain: immich.07c.me

# Admin user
immich_admin_email: admin@07c.me
immich_admin_password: admin123

# Storage
immich_storage_path: /mnt/immich/photos
immich_storage_size: 500Gi
```

## Features Included

✅ **k0s Kubernetes** - Lightweight, production-ready  
✅ **MetalLB** - Load balancer for bare metal  
✅ **Immich** - Modern photo management  
✅ **PostgreSQL** - Database with pgvecto.rs extension  
✅ **Redis** - Caching and job queue  
✅ **Machine Learning** - Face detection, smart search  
✅ **kubectl** - Kubernetes command-line tool  
✅ **k9s** - Terminal UI for Kubernetes management  
✅ **Automatic Setup** - Admin user created automatically  

## Advantages Over GitOps

- ✅ **Simple**: One command deployment
- ✅ **Reliable**: No complex dependencies  
- ✅ **Direct**: No sync delays or conflicts
- ✅ **Debuggable**: Clear error messages
- ✅ **Portable**: Works anywhere Ansible runs

## Management Tools

After deployment, you'll have these tools available on the server:

```bash
# kubectl with useful aliases
kubectl get pods -A        # Full command
k get pods -A             # Short alias
kgp                       # Even shorter for 'get pods'
kgs                       # 'get services'
kga                       # 'get all'

# k9s - Interactive terminal UI
k9s                       # Launch k9s interface

# Other useful aliases
kl deployment/immich-server -n immich  # kubectl logs
kdp pod-name -n immich                 # kubectl describe pod
```

## Maintenance

```bash
# Re-run deployment (idempotent)
ansible-playbook site.yml

# Check status remotely
ansible homelab -m shell -a "kubectl get pods -A"

# Check specific service
ansible homelab -m shell -a "kubectl logs -n immich deployment/immich-server"
```

## Troubleshooting

```bash
# Check all pods
ansible homelab -m shell -a "k0s kubectl get pods -A"

# Check Immich logs  
ansible homelab -m shell -a "k0s kubectl logs -n immich deployment/immich-server"

# Restart services
ansible homelab -m shell -a "systemctl restart k0scontroller"
```

**No more GitOps complexity - just simple, working automation!** 🚀