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
}

