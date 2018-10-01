#!/usr/bin/env bash


(cd terraform && terraform destroy -auto-approve)
#(cd terraform && terraform init; terraform plan; terraform apply -auto-approve)
