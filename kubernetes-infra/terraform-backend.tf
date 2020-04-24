terraform {
  backend "s3" {
    bucket = "thinknyx-terraform-backend"
    key    = "kul-k8s-terraform"
    region = "us-east-1"
  }
}