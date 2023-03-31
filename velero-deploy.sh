echo '-------Deploy Velero for GKE Backup (typically in 3 mins)'
starttime=$(date +%s)
. ./setenv.sh

echo "-------Download and Install verlero CLI if needed"
if [ ! -f velero ]; then
  wget https://github.com/vmware-tanzu/velero/releases/download/v1.10.2/velero-v1.10.2-linux-amd64.tar.gz
  tar -zxvf velero-v1.10.2-linux-amd64.tar.gz
  sudo mv velero-v1.10.2-linux-amd64/velero /usr/local/bin/
  sudo rm velero-v1.10.2-linux-amd64.tar.gz
  sudo rm -rf velero-v1.10.2-linux-amd64
fi

echo "-------Create a GCS storage bucket if not exist"
cat bucket4velero1
if [ `echo $?` -eq 1 ];then
  echo $MY_BUCKET-$(date +%d%H%M%s) > bucket4velero1
  gsutil mb gs://$(cat bucket4velero1)/
fi

echo "-------Create a service account for velero"
gcloud iam service-accounts list | grep vsa4yong1
if [ `echo $?` -eq 1 ];then
  export MY_PROJECT_ID=$(gcloud config get-value project)
  MY_GSA_NAME=vsa4yong1

  gcloud iam service-accounts create $MY_GSA_NAME \
    --display-name "Velero service account"

  MY_SERVICE_ACCOUNT_EMAIL=$(gcloud iam service-accounts list \
    --filter="displayName:Velero service account" \
    --format 'value(email)')

  ROLE_PERMISSIONS=(
    compute.disks.get
    compute.disks.create
    compute.disks.createSnapshot
    compute.snapshots.get
    compute.snapshots.create
    compute.snapshots.useReadOnly
    compute.snapshots.delete
    compute.zones.get
    storage.objects.create
    storage.objects.delete
    storage.objects.get
    storage.objects.list
    iam.serviceAccounts.signBlob
  )

  gcloud iam roles create velero.server \
    --project $MY_PROJECT_ID \
    --title "Velero Server" \
    --permissions "$(IFS=","; echo "${ROLE_PERMISSIONS[*]}")"

  gcloud projects add-iam-policy-binding $MY_PROJECT_ID \
    --member serviceAccount:$MY_SERVICE_ACCOUNT_EMAIL \
    --role projects/$MY_PROJECT_ID/roles/velero.server

  gsutil iam ch serviceAccount:$MY_SERVICE_ACCOUNT_EMAIL:objectAdmin gs://$(cat bucket4velero1)

  gcloud iam service-accounts keys create credentials-velero \
    --iam-account $MY_SERVICE_ACCOUNT_EMAIL
fi

echo "-------Install velero using the SA"
velero install \
    --provider gcp \
    --plugins velero/velero-plugin-for-gcp:v1.6.0 \
    --bucket $(cat bucket4velero1) \
    --secret-file ./credentials-velero

echo "-------Backup yong-postgresql namespace"
velero backup create yong-postgresql-backup --include-namespaces yong-postgresql

endtime=$(date +%s)
duration=$(( $endtime - $starttime ))
echo "" | awk '{print $1}'
echo "-------Total time to build a GKE cluster with PostgreSQL is $(($duration / 60)) minutes $(($duration % 60)) seconds."
echo "" | awk '{print $1}'
echo "-------Created by Yongkang"
echo "-------Email me if any suggestions or issues he@yongkang.cloud"
echo "" | awk '{print $1}'