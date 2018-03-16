#####################################################################
##
##      Created 3/16/18 by ucdpadmin. for project1
##
#####################################################################

## REFERENCE {"default_network":{"type": "aws_reference_network"}}

terraform {
  required_version = "> 0.8.0"
}

provider "aws" {
  access_key = "${var.aws_access_id}"
  secret_key = "${var.aws_secret_key}"
  region     = "${var.region}"
  version = "~> 1.8"
}


resource "aws_instance" "AWS_VM" {
  ami = "${var.AWS_VM_ami}"
  key_name = "${aws_key_pair.auth.id}"
  instance_type = "${var.AWS_VM_aws_instance_type}"
  availability_zone = "${var.availability_zone}"
  subnet_id  = "${var.subnet_id}"
  tags {
    Name = "${var.AWS_VM_name}"
  }
}

resource "aws_instance" "AWS_VM2" {
  ami = "${var.AWS_VM2_ami}"
  key_name = "${aws_key_pair.auth.id}"
  instance_type = "${var.AWS_VM2_aws_instance_type}"
  availability_zone = "${var.availability_zone}"
  subnet_id  = "${var.subnet_id}"
  tags {
    Name = "${var.AWS_VM2_name}"
  }
}

resource "tls_private_key" "ssh" {
    algorithm = "RSA"
}

resource "aws_key_pair" "auth" {
    key_name = "aws-temp-public-key"
    public_key = "${tls_private_key.ssh.public_key_openssh}"
}