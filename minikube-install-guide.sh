#This guide is to help you quickly create a sandbox Kubernetes cluster via Minikube and later you can clean it up entirely by removing the VM created by multipass.

#Install Multipass on Mac ARM
brew install multipass

#Launch an Ubuntu VM
multipass launch --name node4yong1 --cpus 2 --memory 2Gi --disk 20G

#Verify if the Ubuntu VM is running on Mac
multipass list

#Shell into the Ubuntu VM
multipass shell node4yong1

#Install minikube on Ubuntu on Mac ARM
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-arm64
sudo install minikube-linux-arm64 /usr/local/bin/minikube

#Verify if minikube is installed
minikube version

#Start minikube instance 1st attempt
minikube start

#Install podman on Ubuntu
sudo apt update
sudo apt install podman -y

#Start minikube instance again
minikube start

#Verify if minikube is running and Kubernetes version
minikube kubectl -- get nodes
minikube kubectl -- get pods -A
minikube kubectl -- get sc

#Try to deploy an app on minikube
minikube kubectl -- create deployment mydeploy1 --image=nginx
minikube kubectl -- get deployment
minikube kubectl -- get pods -A

#Clean up the environment
#Exit from Ubuntu Shell
exit

#Remove the Ubuntu VM via multipass
multipass stop node4yong1
multipass delete node4yong1
multipass purge
