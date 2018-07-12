#!/bin/bash

POD_NAME=$(kubectl get pod -o json | jq -r '.items[] | select( .metadata.name | contains("server-name")) | .metadata.name')

kubectl::secret::registry::create(){

  gcr_user_email=$1
  gcr_key_file=$2
  
  kubectl create secret docker-registry gcr-key \
    --docker-server=https://asia.gcr.io \
    --docker-username=_json_key \
    --docker-email=${gcr_user_email} \
    --docker-password=$(cat ${gcr_key_file})
}
