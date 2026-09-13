terraform {
  backend "s3" {
    bucket       = "multi-cloud-devsecops-tfstate-149600119261-euc1"
    key          = "terraform/aws/terraform.tfstate"
    region       = "eu-central-1"
    encrypt      = true
    use_lockfile = true
  }
}