terraform {
  backend "s3" {
    bucket = "iac-be-develop-testes-terraform-rapha"
    key    = "iac/fiap/ec2nodes/chp-2"
    region = "us-east-1"
  }
}