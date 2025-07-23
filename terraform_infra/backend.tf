terraform {
  backend "s3" {
    bucket         = "devopseng4ai"
    key            = "lambda/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
  }
}