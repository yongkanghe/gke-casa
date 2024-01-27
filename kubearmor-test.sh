# KubeArmor Test Case -1, deny execution of apt / apt-get

# Get the pod name
export POD=$(kubectl get pod -l app=nginx4yong1 -o name -n yong-nginx)

# Try to run apt / apt-get
kubectl exec -it $POD -n yong-nginx -- bash -c "apt update && apt install masscan"

# Apply the policy to deny execution of apt / apt-get
kubectl apply -f ./block-pkg-mgmt-tools-exec.yaml

# Try to run apt / apt-get again
kubectl exec -it $POD -n yong-nginx -- bash -c "apt update && apt install masscan"

# Verify policy violations
karmor logs -n yong-nginx

# KubeArmor Test Case -2, deny access to service account token

# Try to access the SA
kubectl exec -it $POD -n yong-nginx -- bash
curl https://$KUBERNETES_PORT_443_TCP_ADDR/api --insecure --header "Authorization: Bearer $(cat /run/secrets/kubernetes.io/serviceaccount/token)"

# Apply the policy to deny access to service account token
kubectl apply -f ./block-service-access-token-access.yaml

# Try to access the SA again
forbidden: User \"system:anonymous\" cannot get path \"/api\”




