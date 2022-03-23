#!/bin/bash

set -exv

kubectx general

dir="dump"
mkdir -p ${dir}

declare -a ns=(default
)

# ingress
for n in ${ns[@]}; do
  declare -a ings=(`kubectl get ingress -n ${n} -o jsonpath='{.items[*].metadata.name}'`)
  if [[ ${#ings[@]} -gt 0 ]]; then
    for ing in ${ings[@]}; do
      kubectl get ingress ${ing} -n ${n} -o yaml > ${dir}/${n}-ingress-${ing}.yaml
    done
  fi
done

# secret Opaue
for n in ${ns[@]}; do
  declare -a secrets=(`kubectl get secret -n ${n} -o jsonpath='{.items[?(@.type=="Opaque")].metadata.name}'`)
  if [[ ${#secrets[@]} -gt 0 ]]; then
    for s in ${secrets[@]}; do
      kubectl get secret ${s} -n ${n} -o yaml > ${dir}/${n}-secret-${s}.yaml
    done
  fi
done

# deployment
for n in ${ns[@]}; do
  declare -a deploys=(`kubectl get deploy -n ${n} -o jsonpath='{.items[*].metadata.name}'`)
  if [[ ${#deploys[@]} -gt 0 ]]; then
    for d in ${deploys[@]}; do
      kubectl get deploy ${d} -n ${n} -o yaml > ${dir}/${n}-deploy-${d}.yaml
    done
  fi
done
