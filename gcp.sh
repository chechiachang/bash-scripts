#!/bin/bash

# create a GCP service account; format of account is email address

gcp::iam::serviceaccount::create(){
  declare sa_name=$1

  gcloud iam service-accounts --format='value(email)' create ${sa_name}
}

# create the json key file and associate it with the service account

gcp::iam::serviceaccount::create_key(){
  declare sa_email=$1 gcr_json_key=$2

  gcloud iam service-accounts keys create ${gcr_json_key} --iam-account=${sa_email}
}

# add the IAM policy binding for the defined project and service account

gcp::iam::bind_policy(){
  declare serviceaccount_email=$1 role=$2

  # get the project id
  PROJECT=$(gcloud config list core/project --format='value(core.project)')
  gcloud projects add-iam-policy-binding $PROJECT --member serviceAccount:${serviceaccount_email} --role ${role}
}

# http://docs.heptio.com/content/private-registries/pr-gcr.html
# gcp::gcr::create_gcr_key [new-serviceaccount-name]

gcp::gcr::create_gcr_key(){
  declare sa_name=$1

  sa_email=$(gcp::iam::serviceaccount::create ${sa_name})
  gcp::iam::serviceaccount::create_key ${sa_email} "${sa_name}-gcr.json"
  gcp::iam::bind_policy ${sa_email} "roles/storage.objectViewer"
}
