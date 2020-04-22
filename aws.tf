#Configuring Provider
provider "aws" {
	region = "us-east-1"
}

# Creating CENTOS Server
resource "aws_instance" "centos" {
	ami           = "ami-030ff268bd7b4e8b5"
	instance_type = "t2.micro"
	count = 1
	tags = {
		Name = "Terraform-Demo"
	}
}