provider "aws" {
  region = "sa-east-1"
}

module "criar_instancia" {
  source = "git@github.com:alsysew/Modulo_Terraform.git"
  nome = "EC2-Module"
}
