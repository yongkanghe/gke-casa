echo "-------Creating a Google Cloud Service Account"
myproject=$(gcloud config get-value core/project)
gcloud iam service-accounts create casa-yong-sa --display-name "casa Service Account"
casasaemail=$(gcloud iam service-accounts list --filter "casa-yong-sa" --format="value(email)")
gcloud iam service-accounts keys create --iam-account=${casasaemail} casa-sa-key.json
gcloud projects add-iam-policy-binding ${myproject} --member serviceAccount:${casasaemail} --role "roles/compute.storageAdmin"
gcloud projects add-iam-policy-binding ${myproject} --member serviceAccount:${casasaemail} --role "roles/storage.admin"
echo "-------Enabling Google Kubernetes Engine API"
gcloud services enable container.googleapis.com

clear

echo "-------Google Cloud service account is ready and GKE API enabled"
echo "" | awk '{print $1}'
echo "You are ready to deploy now!"
echo "" | awk '{print $1}'

