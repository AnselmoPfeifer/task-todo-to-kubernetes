#!/usr/bin/env bash

ACTION=${1}

if [ ${ACTION} == 'create' ]; then
    echo "Creating new k8s cluster using terraform apply"
    (cd terraform && terraform init; terraform plan; terraform apply -auto-approve)

elif [ ${ACTION} == 'destroy' ]; then
    echo "Destroying k8s cluster using terraform destroy"
    (cd terraform && terraform destroy -auto-approve)
else
    echo "You have to use: create or destroy"
    exit 1
fi
