#!/usr/bin/env bash

NS='task-todo'
ACTION=${1}

function createdNewEKS() {
    echo "Creating new k8s cluster using terraform apply"
    (cd terraform && terraform init; terraform plan; terraform apply -auto-approve)
    aws eks update-kubeconfig --name cluster-task-todo
    kubectl get svc
    kubectl get nodes
}

function deployApp() {
    echo "Executing the k8s build and deploy"
    kubectl create namespace task-todo || true
    (cd mongo; kubectl apply --filename=k8s-mongo.yaml)
    (cd nodejs && kubectl apply --filename=k8s-nodejs.yaml)
    kubectl get pod -n ${NS}
}


if [ ${ACTION} == 'create' ]; then
    createdNewEKS

elif [ ${ACTION} == 'create-and-deploy' ]; then
    createdNewEKS
    deployApp

elif [ ${ACTION} == 'deploy' ]; then
    deployApp

elif [ ${ACTION} == 'destroy' ]; then
    echo "Destroying k8s cluster using terraform destroy"
    (cd terraform && terraform destroy -auto-approve)

else
    echo "You have to use: create or destroy"
    exit 1
fi
