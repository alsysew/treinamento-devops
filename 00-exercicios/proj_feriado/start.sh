#!/bin/bash
#terraform init
terraform apply -auto-approve
sed -i '$d' hosts
terraform output |awk '/ec2-/ {print}'|sed '1 d'| tr -d '",' > hosts
ansible-playbook -i hosts provisionar.yml -u ubuntu --private-key ~/.ssh/Treinamento-dia2-keypair.pem
terraform output |awk '/ec2-/ {print}'
