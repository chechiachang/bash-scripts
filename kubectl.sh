#!/bin/bash
# References
# - https://kubernetes.io/docs/reference/kubectl/cheatsheet/

__DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source ${__DIR}/system.sh

httpie::install(){

  system::check_command kubectl

}

kubectl::secret::registry::create(){

  declare gcr_user_email=$1 gcr_key_file=$2
  
  kubectl create secret docker-registry gcr-key \
    --docker-server=https://asia.gcr.io \
    --docker-username=_json_key \
    --docker-email=${gcr_user_email} \
    --docker-password=$(cat ${gcr_key_file})

}

kubectl::pod::get(){

  declare pod_name=$1
  kubectl get pod -o json | jq -r '.items[] | select( .metadata.name | contains("'${pod_name}'")) | .metadata.name'

}

kubectl::busybox::apply(){

cat <<EOF | kubectl create -f -
apiVersion: v1
kind: Pod
metadata:
  name: busybox-tool
  namespace: default
spec:
  containers:
  - image: busybox
    command:
      - sleep
      - "3600"
    imagePullPolicy: IfNotPresent
    name: busybox
  restartPolicy: Always
EOF

}

kubectl::service::debug(){

  declare service_name=$1

  kubectl::busybox::apply

  kubectl exec -it busybox-tool nslookup ${service_name}

}
