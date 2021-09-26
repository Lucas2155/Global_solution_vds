terraform {
  backend "s3" {
    bucket = "cloudit-fiap-iac"
    key    = "iac/fiap/vpc/vpca"
    region = "us-east-1"
  }
}