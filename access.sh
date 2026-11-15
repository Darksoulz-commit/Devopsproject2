```bash
#!/bin/bash
set -euo pipefail

AWS_REGION="ap-south-1"
CLUSTER_NAME="amazon-prime-cluster"

echo "Connecting to EKS cluster..."

aws eks update-kubeconfig \
  --region "$AWS_REGION" \
  --name "$CLUSTER_NAME"

echo "Getting application URLs and credentials..."

# ArgoCD
ARGO_HOST=$(kubectl get svc argocd-server -n argocd \
  -o jsonpath='{.status.loadBalancer.ingress[0].hostname}')

ARGO_USER="admin"
ARGO_PASSWORD=$(kubectl get secret argocd-initial-admin-secret \
  -n argocd -o jsonpath='{.data.password}' | base64 --decode)

# Prometheus
PROMETHEUS_HOST=$(kubectl get svc monitoring-kube-prometheus-prometheus \
  -n prometheus -o jsonpath='{.status.loadBalancer.ingress[0].hostname}')

# Grafana
GRAFANA_HOST=$(kubectl get svc monitoring-grafana \
  -n prometheus -o jsonpath='{.status.loadBalancer.ingress[0].hostname}')

GRAFANA_USER="admin"
GRAFANA_PASSWORD=$(kubectl get secret monitoring-grafana \
  -n prometheus -o jsonpath='{.data.admin-password}' | base64 --decode)

echo "------------------------"
echo "ArgoCD URL: https://${ARGO_HOST}"
echo "ArgoCD User: ${ARGO_USER}"
echo "ArgoCD Password: ${ARGO_PASSWORD}"
echo
echo "Prometheus URL: http://${PROMETHEUS_HOST}:9090"
echo
echo "Grafana URL: http://${GRAFANA_HOST}"
echo "Grafana User: ${GRAFANA_USER}"
echo "Grafana Password: ${GRAFANA_PASSWORD}"
echo "------------------------"
``` cd