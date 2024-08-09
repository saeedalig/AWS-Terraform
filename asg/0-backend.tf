terraform {
  backend "s3" {
    bucket         = "dev-backend-app"
    key            = "terraform/state.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-lock"
    encrypt        = true
  }
}
