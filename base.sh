#!/bin/bash
# A bash script base

set -euo pipefail
IFS=$'\n\t'

print_usage(){
  echo "Description......"
  echo "Usage: $(basename "$0") --option option1"
  echo "Options:"
  echo "  --option option1: an option"
  echo "Example:"
  echo "$(basename "$0") --option option1"
}

for i in "$@"; do
  case $i in
    -p|--package) shift; installer_package_file=$1; shift;;
    --ips) shift; break ;;
    *) print_usage; exit 1;;
  esac
done
