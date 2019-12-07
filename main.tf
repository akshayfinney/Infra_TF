# Define provider and region
# The credentials should be located in your user path
# Create 

provider "aws" {
    region                  = "us-west-2"
    shared_credentials_file = "/Users/akshayfinney/.aws/credentials"
    profile                 = "mfa"
    assume_role {
     role_arn  = "arn:aws:iam::367805628163:role/TIQ_Admin"
    }
}

resource "aws_instance" "testservice" {
    ami         = "${data.aws_ami.ubuntu.id}"
    instance_type = "t2.micro"
    tags = {
    Name = "textiqtest"
    }
    tags = {
        Terraform   = "true"
        Environment = "Dev"
    }
}

# Adding S3 Bucket backend to store TF-Statefiles
resource "aws_s3_bucket" "tfstate" {
  bucket = "tf-dev-state"
  acl    = "private"
  versioning {
      enabled = true
  }

  logging {
      target_bucket = "${aws_s3_bucket.tf_logs.id}"
      target_prefix = "log/"
  }

  server_side_encryption_configuration {
      rule {
          apply_server_side_encryption_by_default {
              kms_master_key_id = "${aws_kms_key.mykey.arn}"
              sse_algorithm = "aws:kms"
          }
      }
  }
  tags = {
    Name        = "tfstate"
    Environment = "Dev"
  }

}

# Adding an S3 bucket to capture state logs as well
# Any writes will be captured by this bucket
resource "aws_s3_bucket" "tf_logs" {
    bucket = "Tf-State-Logs"
    acl = "log-delivery-write"
}

# Enabling Server Side encryption

resource "aws_kms_key" "mykey" {
    description = "Encrypt bucket objects"
  
}

