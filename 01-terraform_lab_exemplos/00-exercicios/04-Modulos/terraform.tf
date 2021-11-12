terraform {
  backend "remote" {
    organization = "santi-corp"

    workspaces {
      name = "santi-workspace"
    }
  }
}
