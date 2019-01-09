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

kubectl::pod::wait(){

  for counter in $(seq 1 10); do
    pending_pod_names=$(kubectl get pod --field-selector=status.phase=Pending -o=go-template="{{range .items}}{{.metadata.name}}{{end}}")
    if [[ ${pending_pod_names} == "" ]]; then
      echo "No pending pods" && exit 0
    fi
    echo "Wait for Pending pods...${counter}" && sleep 5
  done
  echo "Timeout waiting for Pending pods." && exit 1

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
