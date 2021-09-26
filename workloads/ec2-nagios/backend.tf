terraform {
  backend "s3" {
    bucket = "cloudit-fiap-iac"
    key    = "iac/fiap/ec2/chp-2"
    region = "us-east-1"
  }
}