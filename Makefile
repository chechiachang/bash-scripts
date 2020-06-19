SUBDIRS := $(filter-out modules/. templates/., $(wildcard */.))
SHELL := /bin/bash

bats:
	bats .

# Shell variable: Always use $$ escape $ so that make won't try to expend VAR

# VAR=new-text make sed
sed:
	sed -e "s!TEXT_TO_REPLACE!$${VAR}!g" text
sed-inplace:
	sed -i '' -e  "s!TEXT_TO_REPLACE!$${VAR}!g" text

# Shell parameter extension
# VAR=one-one-two-three make variable
variable:
	echo $(SUBDIRS)
	echo $${VAR}
	echo $${VAR#*-}

# Kubectl
EXCLUDE_DIR := ./resources(alpha)

check:
	kubectl config use-context gke_dabenxiang226_asia-east1_its-tekton-k8s-tw-01

diff-dry-run:
	cd ..; git --no-pager diff --name-only HEAD master | grep '.yaml' | xargs kubectl apply --server-dry-run -f

dry-run: check
  declare -a dirs=($$(find . -maxdepth 1 -type d -not -path '.' -not -path '$(EXCLUDE_DIR)')); \
  echo "$${dirs[@]}"; \
  for dir in "$${dirs[@]}"; do kubectl apply --server-dry-run --filename $${dir}; done

apply: check
  declare -a dirs=($$(find . -maxdepth 1 -type d -not -path '.' -not -path '$(EXCLUDE_DIR)')); \
  echo "$${dirs[@]}"; \
  for dir in "$${dirs[@]}"; do kubectl apply --filename $${dir}; done
