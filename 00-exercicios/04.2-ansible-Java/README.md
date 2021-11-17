# rodar playbook no ansible
ansible-playbook -i hosts provisionar.yml -u ubuntu --private-key ~/.ssh/Treinamento-dia2-keypair.pem

# acesso ssh maquina
ssh -i "~/.ssh/Treinamento-dia2-keypair.pem" ubuntu@ec2-54-234-131-240.compute-1.amazonaws.com 
