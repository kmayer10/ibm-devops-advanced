#Configuring Provider
provider "aws" {
	region = "us-east-1"
}

# Creating CENTOS Server
resource "aws_instance" "centos" {
	ami           = "ami-030ff268bd7b4e8b5"
	instance_type = "t2.micro"
	count = var.instance_count
	security_groups = [
        aws_security_group.security_group.name
    ]
	tags = {
		Name = var.name
	}
}

resource "aws_security_group" "security_group" {
  name        = var.name
  description = "Allow TLS inbound traffic"
  
  ingress {
    description = "TLS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  ingress {
    description = "TLS from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.name
  }
}

resource "aws_ebs_volume" "volume" {
  availability_zone = var.aws_az
  size              = 10
  count				= var.instance_count
  tags = {
    Name = var.name
  }
}

resource "aws_volume_attachment" "myserverebsattch" {
  count = var.instance_count
  device_name = "/dev/sdf"
  volume_id = aws_ebs_volume.volume[count.index].id
  instance_id = aws_instance.centos[count.index].id
}