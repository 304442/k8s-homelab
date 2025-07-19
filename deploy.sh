#!/bin/bash
set -e

echo "🚀 k8s-homelab Ansible Deployment"
echo "================================="

# Check if ansible is installed
if ! command -v ansible-playbook &> /dev/null; then
    echo "❌ Ansible not found. Installing..."
    pip3 install -r ansible/requirements.txt
fi

echo "✅ Starting deployment..."
cd ansible

# Run the playbook
ansible-playbook site.yml

echo ""
echo "🎉 Deployment Complete!"
echo "======================="
echo ""
echo "🎯 Access Immich at: http://immich.07c.me"
echo "📧 Username: admin@07c.me"  
echo "🔑 Password: admin123"
echo ""
echo "🏗️ Infrastructure deployed:"
echo "   - k0s Kubernetes cluster"
echo "   - MetalLB load balancer"
echo "   - Immich photo management"
echo "   - PostgreSQL with vector support"
echo "   - Redis caching"
echo "   - Machine learning features"
echo ""
echo "✨ No more GitOps complexity - just simple, working automation!"