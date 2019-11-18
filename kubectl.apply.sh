# Create a namespace
kubectl apply -f k8s-deploy/ns.yaml 

# Deploy the rest
kubectl apply -f k8s-deploy/sa.yaml
kubectl apply -f k8s-deploy/clusterrolebinding.yaml
kubectl apply -f k8s-deploy/configmap.yaml
kubectl apply -f k8s-deploy/secret.yaml
kubectl apply -f k8s-deploy/deployment.yaml
kubectl apply -f k8s-deploy/service.yaml
kubectl apply -f k8s-deploy/ingress.yaml
