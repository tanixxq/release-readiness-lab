
#!/bin/bash
set -e

echo "============================================="
echo "Starting deployment of Checkout API Service..."
echo "Deployment Version: v2.4"
echo "============================================="

# Ensure namespace exists
echo "Checking namespace..."
kubectl get namespace checkout-system || kubectl create namespace checkout-system

# Verify required Kubernetes Secret and keys
echo "Checking production secrets..."

kubectl get secret checkout-api-secrets -n checkout-system \
  -o jsonpath='{.data.DATABASE_URL}' | grep -q . || {
    echo "DATABASE_URL missing from Kubernetes Secret"
    exit 1
  }

kubectl get secret checkout-api-secrets -n checkout-system \
  -o jsonpath='{.data.REDIS_URL}' | grep -q . || {
    echo "REDIS_URL missing from Kubernetes Secret"
    exit 1
  }

echo "Production secrets verified."

# Apply Kubernetes manifests
echo "Applying Kubernetes manifests..."
kubectl apply -f k8s/configmap.yaml
kubectl apply -f k8s/deployment.yaml
kubectl apply -f k8s/service.yaml

echo "============================================="
echo "Deployment candidate v2.4 applied."
echo "Verify status using: kubectl get pods -n checkout-system"
echo "============================================="
