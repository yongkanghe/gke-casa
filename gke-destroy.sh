starttime=$(date +%s)
. ./setenv.sh
echo '-------Deleting the GKE Cluster (typically in few mins)'
TEMP_PREFIX=$(echo $(whoami) | sed -e 's/\_//g' | sed -e 's/\.//g' | awk '{print tolower($0)}')
FIRST2=$(echo -n $TEMP_PREFIX | head -c2)
LAST2=$(echo -n $TEMP_PREFIX | tail -c2)
MY_PREFIX=$(echo $FIRST2$LAST2)

gkeclustername=$(gcloud container clusters list --format="value(name)" --filter="$MY_PREFIX-$MY_CLUSTER")
gcloud container clusters delete $gkeclustername --zone $MY_ZONE --quiet
findmydisk=$(echo $MY_PREFIX-$MY_CLUSTER | head -c 12)

echo '-------Deleting disks'
for i in $(gcloud compute disks list --format="value(name)" --filter="yong-postgresql");do echo $i;gcloud compute disks delete $i --zone=$MY_ZONE -q;done

echo '-------Deleting snapshots'
for i in $(gcloud compute snapshots list --format="value(name)" --filter="GCE-PD CSI Driver");do echo $i;gcloud compute snapshots delete $i -q;done

echo '-------Deleting the bucket'
myproject=$(gcloud config get-value core/project)
gsutil -m rm -r gs://$MY_PREFIX-$MY_BUCKET

echo '-------Deleting kubeconfig for this cluster'
kubectl config delete-context $(kubectl config get-contexts | grep $MY_PREFIX-$MY_CLUSTER | awk '{print $2}')

echo "" | awk '{print $1}'
endtime=$(date +%s)
duration=$(( $endtime - $starttime ))
echo "-------Total time is $(($duration / 60)) minutes $(($duration % 60)) seconds."
echo "" | awk '{print $1}'
echo "-------Created by Yongkang"
echo "-------Email me if any suggestions or issues he@yongkang.cloud"