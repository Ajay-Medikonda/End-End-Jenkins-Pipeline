provider "aws" {
    region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket = "ajayjenkinsbucket"
    key    = "pipeline.tfstate"
    region = "us-east-1"
  }
}

data "aws_ami" "my_ami" {
     most_recent      = true
     #name_regex       = "^ajay"
     owners           = ["796732111989"]
}


resource "aws_instance" "web-1" {
    ami = "${data.aws_ami.my_ami.id}"
    #ami = "ami-0d857ff0f5fc4e03b"
    availability_zone = "us-east-1a"
    instance_type = "t2.micro"
    key_name = "Keypair"
    subnet_id = "subnet-06cc8871db734eb74"
	private_ip = "10.0.1.111"
    vpc_security_group_ids = ["sg-06185d7d1792c69a0"]
    associate_public_ip_address = true	
    tags = {
        Name = "Server-1"
        Env = "Prod"
        Owner = "Ajay"
    }
}
