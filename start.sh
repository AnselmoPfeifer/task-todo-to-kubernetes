#!/usr/bin/env bash

ACTION=${1}

if [ ${ACTION} == 'create' ]; then
    echo "Creating new k8s cluster using terraform apply"
    (cd terraform && terraform init; terraform plan; terraform apply -auto-approve)
    aws eks update-kubeconfig --name cluster-task-todo
    kubectl get svc
    kubectl get nodes

elif [ ${ACTION} == 'deploy' ]; then
    echo "Executing the k8s build and deploy"
    # (cd mongo && build.sh && kubectl apply --filename=k8s-mongo.yaml)
    # (cd nodejs && build.sh && kubectl apply --filename=k8s-nodejs.yaml)

elif [ ${ACTION} == 'destroy' ]; then
    echo "Destroying k8s cluster using terraform destroy"
    (cd terraform && terraform destroy -auto-approve)

else
    echo "You have to use: create or destroy"
    exit 1
fi
