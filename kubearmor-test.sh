# KubeArmor Test Case -1, deny execution of apt / apt-get

# Get the pod name
export POD=$(kubectl get pod -l app=nginx4yong1 -o name -n yong-nginx)

# Try to run apt / apt-get
kubectl exec -it $POD -n yong-nginx -- bash -c "apt update && apt install masscan"

# Apply the policy
kubectl apply -f ./block-pkg-mgmt-tools-exec.yaml

# Try to run apt / apt-get again
kubectl exec -it $POD -n yong-nginx -- bash -c "apt update && apt install masscan"

# Verify policy violations
karmor logs -n yong-nginx --json




