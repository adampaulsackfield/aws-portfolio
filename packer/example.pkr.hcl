variable "aws_region" {
  default = getenv("AWS_DEFAULT_REGION_PERSONAL")
}

variable "aws_ami_name" {
  default = "portfolio-web-server"
}

variable "aws_access_key" {
  default = getenv("AWS_ACCESS_KEY_ID_PERSONAL")
}

variable "aws_secret_key" {
  default = getenv("AWS_SECRET_ACCESS_KEY_PERSONAL")
}

packer {
  required_plugins {
    amazon = {
      version = ">= 1.1.1"
      source = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "portfolio-ami" {
  access_key                  = var.aws_access_key
  secret_key                  = var.aws_secret_key
  ami_name                    = var.aws_ami_name
  region                      = var.aws_region
  instance_type               = "t2.micro"
  ssh_username                = "ubuntu"
  vpc_id                      = "vpc-0c41b2b8326ffeeef"
  subnet_id                   = "subnet-0ad522616d1675207"
  ami_description             = "Web Server AMI"
  associate_public_ip_address = true

  source_ami_filter {
    filters = {
      "virtualization-type" = "hvm"
      "name"                = "ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"
      "root-device-type"    = "ebs"
    }

    owners      = ["099720109477"]
    most_recent = true
  }
}