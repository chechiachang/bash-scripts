#!/bin/bash

#https://stackoverflow.com/questions/592620/how-to-check-if-a-program-exists-from-a-bash-script
check_aws_cli(){

  if hash aws 2>/dev/null; then
    echo "Using aws-cli $(which aws)"
  else
    echo "Failed to find command aws. Install with 'pip install aws-cli'"
    exit 1
  fi

}

aws::instance::run(){
  
  BLOCK_DEVICE_MAPPING='DeviceName=/dev/sdb,VirtualName=/dev/sdb,Ebs={Encrypted=false,DeleteOnTermination=false,VolumeSize=600,VolumeType=sc1}'
  IMAGE_ID='ami-48a45937'
  INSTANCE_TYPE="t2.medium"
  KEY_NAME="key-name"
  #SUBNET_ID="Subnet-17cbe55e"
  COUNT=3 
  ASSOCIATE_PUBLIC_IP_ADDRESS=true
  INSTANCE_MARKET_OPTIONS='MarketType=spot,SpotOptions={MaxPrice=0.3,SpotInstanceType=persistent,InstanceInterruptionBehavior=stop}'

  declare -a options=()
  if [[ ! -z ${BLOCK_DEVICE_MAPPING} ]]; then options+=( "--block-device-mapping ${BLOCK_DEVICE_MAPPING}" ); fi
  if [[ ! -z ${IMAGE_ID} ]]; then options+=("--image-id ${IMAGE_ID}" ); fi
  if [[ ! -z ${INSTANCE_TYPE} ]]; then options+=( "--instance-type ${INSTANCE_TYPE}" ); fi
  if [[ ! -z ${KEY_NAME} ]]; then options+=( "--key-name ${KEY_NAME}" ); fi
  if [[ ! -z ${SUBNET_ID} ]]; then options+=( "--subnet-id ${SUBNET_ID}" ); fi
  if [[ ! -z ${COUNT} ]]; then options+=( "--count ${COUNT}" ); fi
  if [[ ! -z ${ASSOCIATE_PUBLIC_IP_ADDRESS} ]]; then options+=( "--associate-public-ip-address" ); fi
  if [[ ! -z ${INSTANCE_MARKET_OPTIONS} ]]; then options+=( "--instance-market-options ${INSTANCE_MARKET_OPTIONS}" ); fi

  aws ec2 run-instances ${options[@]} > instance.json
  
  declare -a instance_ids=($(cat instance.json | jq .Instances[].PrivateIpAddress))
  
  echo "EC2 instances creating with ips: ${instance_ids[@]}"
}
