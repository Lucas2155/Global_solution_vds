terraform {
  backend "s3" {
    bucket = "iac-be-develop-testes-terraform-rapha"
    key    = "iac/fiap/vpc/vpca"
    region = "us-east-1"
  }
}