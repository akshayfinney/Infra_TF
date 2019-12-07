terraform {
    backend "s3" {
        bucket = "tf-dev-state"
        key = "terraform.tfstate"
        region = "us-west-2"
    }
}