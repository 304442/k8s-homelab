# SSL Certificate Issue Resolution

## Problem
Caddy kept reverting to production Let's Encrypt endpoint despite staging configuration in ConfigMap, causing SSL_ERROR_INTERNAL_ERROR_ALERT due to rate limiting.

## Root Cause
- Let's Encrypt production endpoint hit 5 certificates/week rate limit
- Caddy cached old configuration and certificates
- ConfigMap changes weren't picked up by running pod

## Solution Applied
1. **Repository has correct staging config** ✅
   ```yaml
   acme_ca https://acme-staging-v02.api.letsencrypt.org/directory
   ```

2. **Force pod restart to clear cache** ✅
   ```bash
   kubectl delete pod -n caddy-system -l app=caddy-ingress-controller
   ```

3. **Verify staging certificates work** ✅
   - HTTPS working: `https://immich.07c.me/api/server/ping` → `{"res":"pong"}`
   - Web interface loading properly

## Prevention
- Configuration is in repository and will persist through GitOps
- If issue recurs: restart Caddy pod to clear cached certificates
- Production certificates will work automatically after July 20, 2025

## Status
✅ **RESOLVED**: HTTPS working with staging certificates  
✅ **Repository updated**: Configuration committed and maintained

## Test Commands
```bash
# Test API
curl -k https://immich.07c.me/api/server/ping

# Test web interface  
curl -k https://immich.07c.me/

# Restart Caddy if needed
kubectl delete pod -n caddy-system -l app=caddy-ingress-controller
```