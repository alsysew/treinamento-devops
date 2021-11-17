#!/bin/bash

terraform init
terraform apply -auto-approve

echo  "Aguardando a criação das maquinas ..."
sleep 5

HOST_DNS=$(terraform output | grep 'PUBLIC_DNS=' | awk '{print $1;exit}' | cut -b 13- | sed "s/\",//g")

echo "
[ec2-java]
$HOST_DNS
" > ansible/hosts

cd ansible

ANSIBLE_HOST_KEY_CHECKING=False USER=root PASSWORD=root DATABASE=SpringWebYoutube ansible-playbook -i hosts provisionar.yml -u ubuntu --private-key ~/.ssh/Treinamento-dia2-keypair.pem 

echo  "Abrindo site no navegador"
sleep 10

open "http://$HOST_DNS"

echo  "Acessando via SH"
sleep 5
ssh -i "~/.ssh/Treinamento-dia2-keypair.pem" ubuntu@$HOST_DNS -o ServerAliveInterval=60