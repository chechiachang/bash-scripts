#!/bin/bash
# References
# - https://kubernetes.io/docs/reference/kubectl/cheatsheet/

POD_NAME=$(kubectl get pod -o json | jq -r '.items[] | select( .metadata.name | contains("server-name")) | .metadata.name')

kubectl::pod::wait_running(){

  pod_name=$1

}

kubectl::secret::registry::create(){

  gcr_user_email=$1
  gcr_key_file=$2
  
  kubectl create secret docker-registry gcr-key \
    --docker-server=https://asia.gcr.io \
    --docker-username=_json_key \
    --docker-email=${gcr_user_email} \
    --docker-password=$(cat ${gcr_key_file})
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
  service_name=$1

  kubectl::busybox::apply

  kubectl exec -it busybox-tool nslookup ${service_name}

}
