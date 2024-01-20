echo '-------Creating a GKE Cluster only (typically in ~6 mins)'
starttime=$(date +%s)
. ./setenv.sh
TEMP_PREFIX=$(echo $(whoami) | sed -e 's/\_//g' | sed -e 's/\.//g' | awk '{print tolower($0)}')
FIRST3=$(echo -n $TEMP_PREFIX | head -c3)
LAST3=$(echo -n $TEMP_PREFIX | tail -c3)
MY_PREFIX=$(echo $FIRST3$LAST3)
GKE_K8S_VERSION=$(gcloud container get-server-config --region us-central1 --flatten="channels" --filter="channels.channel=RAPID" | grep $K8S_VERSION | awk '{print $2}' | sort -r | uniq | head -1)
#GKE_K8S_VERSION=1.28.1-gke.1066000
#GKE_K8S_VERSION=1.27.2-gke.1200
#GKE_K8S_VERSION=1.26.1-gke.1500

gcloud container clusters create $MY_PREFIX-$MY_CLUSTER-$(date +%s) \
  --zone $MY_ZONE \
  --num-nodes 1 \
  --machine-type $MY_MACHINE_TYPE \
  --release-channel=rapid \
  --cluster-version $GKE_K8S_VERSION \
  --no-enable-basic-auth \
  --addons=GcePersistentDiskCsiDriver \
  --enable-autoscaling --min-nodes 1 --max-nodes 3

echo "" | awk '{print $1}'
./postgresql-deploy.sh

endtime=$(date +%s)
duration=$(( $endtime - $starttime ))
echo "" | awk '{print $1}'
echo "-------Total time to build a GKE cluster with PostgreSQL is $(($duration / 60)) minutes $(($duration % 60)) seconds."
echo "" | awk '{print $1}'
echo "-------Created by Yongkang"
echo "-------Email me if any suggestions or issues he@yongkang.cloud"
echo "" | awk '{print $1}'