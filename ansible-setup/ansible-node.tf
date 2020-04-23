# Creating CENTOS Server
resource "aws_instance" "ansible-node" {
	ami           	= 	"ami-030ff268bd7b4e8b5"
	instance_type 	= 	var.node_instance_type
	count 			= 	var.node_instance_count
	key_name		= 	"Kul-Thinknyx"

	security_groups = [
        aws_security_group.security_group.name
    ]
		
	tags = {
		Name 		= 	"ansible-node"
	}
	
	provisioner "remote-exec" {
	
		connection {
			type = "ssh"
			user = "root"
			password = "thinknyx@123"
			host = self.public_ip
		}
		inline = [
			"sudo hostnamectl set-hostname ansible-node"
		]
	}
	
	provisioner "remote-exec" {
		connection {
			type = "ssh"
			user = "root"
			password = "thinknyx@123"
			host = aws_instance.ansible-master[count.index].public_ip
		}
		inline = [
			"echo ${self.public_ip} >> /etc/ansible/hosts"
		]
	}
	
}