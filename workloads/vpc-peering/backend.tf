terraform {
  backend "s3" {
    bucket = "iac-be-develop-testes-terraform-rapha"
    key    = "iac/fiap/peering/peering"
    region = "us-east-1"
  }
}