echo '-------Remove Velero for GKE and Clean up (typically in 3 mins)'
starttime=$(date +%s)
. ./setenv.sh

velero uninstall --force
# gsutil rm -r gs://$(cat bucket4velero1)
gsutil rm -a gs://$(cat bucket4velero1)/**
# rm bucket4velero1
rm yongsa4velero1
gcloud iam service-accounts delete $(gcloud iam service-accounts list | grep vsa4yong1 | awk '{print $2}') -q

endtime=$(date +%s)
duration=$(( $endtime - $starttime ))
echo "" | awk '{print $1}'
echo "-------Total time to clean up the env is $(($duration / 60)) minutes $(($duration % 60)) seconds."
echo "" | awk '{print $1}'
echo "-------Created by Yongkang"
echo "-------Email me if any suggestions or issues he@yongkang.cloud"
echo "" | awk '{print $1}'