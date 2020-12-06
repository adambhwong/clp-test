#!/bin/bash
cd ~/
git clone https://$CFG_REPO_USER:$CFG_REPO_PASSWORD@$CI_SERVER_HOST/$CI_APPLICATION_REPOSITORY.git tf
cd tf
terraform init
terraform apply -auto-approve
