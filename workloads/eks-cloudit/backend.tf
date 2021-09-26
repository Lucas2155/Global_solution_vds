terraform {
  backend "s3" {
    bucket = "cloudit-fiap-iac"
    encrypt = true
    key    = "iac/fiap/eks/select/eks-cloud-it.tfsatte"
    region = "us-east-1"
  }
}