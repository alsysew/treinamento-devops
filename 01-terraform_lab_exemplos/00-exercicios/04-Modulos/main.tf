

module "criar_instancia" {
#  source = "./instancia"
  source = "git@github.com:alsysew/Modulo_Terraform.git"  

  nome = "EC2-Module"
}
