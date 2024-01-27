# Add helm chart repo
helm repo add kubearmor https://kubearmor.github.io/charts 
helm repo update kubearmor

# Install KubeArmor
helm upgrade --install kubearmor-operator kubearmor/kubearmor-operator -n yong-kubearmor --create-namespace 
kubectl apply -f ./kubearmor-sample-config.yaml

# Install KubeArmor CLI
curl -sfL http://get.kubearmor.io/ | sudo sh -s -- -b /usr/local/bin

# Deploy a test nginx app
kubectl create namespace yong-nginx
kubectl create deployment nginx4yong1 --image=nginx -n yong-nginx
POD=$(kubectl get pod -l app=nginx4yong1 -o name -n yong-nginx)
