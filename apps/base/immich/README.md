# Immich Photo Management

Complete Immich deployment for k8s-homelab with automatic initialization.

## Components

- **Immich Server**: Main application server (port 2283)
- **Microservices**: Background processing and jobs
- **Machine Learning**: AI features (face detection, smart search)
- **PostgreSQL**: Database with pgvecto.rs extension
- **Redis**: Caching and job queue
- **Persistent Storage**: 500Gi for photo/video storage

## Access

- **URL**: https://immich.07c.me
- **Default Admin**: admin@07c.me / admin123

## Features Configured

- ✅ Automatic admin user creation
- ✅ Machine learning enabled (face detection, CLIP search)
- ✅ Storage template: `{{y}}/{{y}}-{{MM}}-{{dd}}/{{filename}}`
- ✅ Thumbnail generation optimized
- ✅ Trash enabled (30 day retention)
- ✅ External domain configured
- ✅ Custom welcome message

## Manual Setup Steps

After deployment, the initialization job will:

1. Wait for Immich server to be ready
2. Create admin user if it doesn't exist
3. Apply system configuration

## Storage

Photos and videos are stored in `/mnt/immich/photos` on the host, mounted to `/usr/src/app/upload` in containers.

## Verification

```bash
# Check all pods running
kubectl get pods -n immich

# Test API
curl -k https://immich.07c.me/api/server/ping

# Check initialization job
kubectl get jobs -n immich
kubectl logs -n immich job/immich-init
```

## Version

Currently deployed: **Immich v1.135.3**