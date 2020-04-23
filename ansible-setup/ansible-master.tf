provider "aws" {
	region = "us-east-1"
}

# Creating CENTOS Server
resource "aws_instance" "ansible-master" {
	ami           	= 	"ami-030ff268bd7b4e8b5"
	instance_type 	= 	var.master_instance_type
	count 			= 	var.master_instance_count
	key_name		= 	"Kul-Thinknyx"

	security_groups = [
        aws_security_group.security_group.name
    ]
	
	tags = {
		Name 		= 	"ansible-master"
	}
	
	provisioner "remote-exec" {
	
		connection {
			type = "ssh"
			user = "root"
			password = "thinknyx@123"
			host = self.public_ip
		}
		inline = [
			"sudo hostnamectl set-hostname ansible-master",
			"sudo yum install -y wget",
			"sudo wget https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm",
			"sudo yum install -y ansible",
			"sudo echo 'host_key_checking = False' >> /etc/ansible/ansible.cfg"
		]
	}
	
	provisioner "local-exec" {
		command = "echo ${self.public_ip} > public_ip"
	}
	
}