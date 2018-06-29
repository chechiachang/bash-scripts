#!/bin/bash

POD_NAME=$(kubectl get pod -o json | jq -r '.items[] | select( .metadata.name | contains("server-name")) | .metadata.name')
