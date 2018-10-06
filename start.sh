#!/usr/bin/env bash

NS='task-todo'
ACTION=${1}

if [ ${ACTION} == 'create' ]; then
    echo "Creating new k8s cluster using terraform apply"
    (cd terraform && terraform init; terraform plan; terraform apply -auto-approve)
    aws eks update-kubeconfig --name cluster-task-todo
    kubectl get svc
    kubectl get nodes

elif [ ${ACTION} == 'deploy' ]; then
    echo "Executing the k8s build and deploy"
    kubectl create namespace task-todo || true
    (cd mongo; kubectl apply --filename=k8s-mongo.yaml)
    (cd nodejs && build-image.sh && kubectl apply --filename=k8s-nodejs.yaml)
    kubectl get pod -n ${NS}

elif [ ${ACTION} == 'destroy' ]; then
    echo "Destroying k8s cluster using terraform destroy"
    (cd terraform && terraform destroy -auto-approve)

else
    echo "You have to use: create or destroy"
    exit 1
fi
