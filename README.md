#### Follow [@YongkangHe](https://twitter.com/yongkanghe) on Twitter, Subscribe [K8s Data Management](https://www.youtube.com/channel/UCm-sw1b23K-scoVSCDo30YQ?sub_confirmation=1) Youtube Channel

I just want to build a GKE Cluster to play with the various Data Management capabilities e.g. Backup/Restore, Disaster Recovery and Application Mobility. It is challenging to create a GKE cluster from Google Cloud if you are not familiar to it. After the GKE Cluster is up running, we still need to install a sample DB etc.. The whole process is not that simple.

This script based automation allows you to build a ready-to-use GKE cluster with PostgreSQL in about 5 minutes. For simplicity and cost optimization, the GKE cluster will have only one worker node and be built in the default vpc using the default subnet. This is bash shell based scripts which has been tested on Cloud Shell. Linux or MacOS terminal has not been tested though it might work as well. 

# Create a Google Cloud Trial Account
[![IMAGE ALT TEXT HERE](https://img.youtube.com/vi/rjZsH3IeSrE/0.jpg)](https://www.youtube.com/watch?v=rjZsH3IeSrE)
#### Subscribe [K8s Data Management](https://www.youtube.com/channel/UCm-sw1b23K-scoVSCDo30YQ?sub_confirmation=1) Youtube Channel

# Here're the prerequisities. 
1. Go to open Google Cloud Shell
2. Clone the github repo to your local host, run below command
````
git clone https://github.com/yongkanghe/gke-casa.git
````
3. Create gcloud service account first
````
cd gke-casa;./createsa.sh
````
4. Optionally, you can customize the clustername, machine-type, zone, region
````
vi setenv.sh
````

5. To deploy a GKE cluster
````
./gke-deploy.sh
````

6. To destroy the GKE cluster after testing
````
./gke-destroy.sh
````

# Build a GKE cluster via Web UI
[![IMAGE ALT TEXT HERE](https://img.youtube.com/vi/YwfPqR5phLM/0.jpg)](https://www.youtube.com/watch?v=YwfPqR5phLM)
#### Subscribe [K8s Data Management](https://www.youtube.com/channel/UCm-sw1b23K-scoVSCDo30YQ?sub_confirmation=1) Youtube Channel

# Build, Protect and Migrate Containers
[![IMAGE ALT TEXT HERE](https://pbs.twimg.com/media/FK5rsaeXwAIEmtI?format=jpg&name=small)](https://www.youtube.com/channel/UCm-sw1b23K-scoVSCDo30YQ)
#### Subscribe [K8s Data Management](https://www.youtube.com/channel/UCm-sw1b23K-scoVSCDo30YQ?sub_confirmation=1) Youtube Channel

# CloudCasa - No. 1 Kubernetes Backup as a Service
https://cloudcasa.io 

# FREE Kubernetes Learning
https://kubecampus.io 

# Contributors
#### Follow [Yongkang He](http://yongkang.cloud) on LinkedIn, Join [Kubernetes Data Management](https://www.linkedin.com/groups/13983251) LinkedIn Group

