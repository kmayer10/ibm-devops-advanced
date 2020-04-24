resource "aws_instance" "k8s-master" {
	ami           	= 	"ami-030ff268bd7b4e8b5"
	instance_type 	= 	var.master_instance_type
	key_name		= 	"Kul-Thinknyx"

	security_groups = [
        aws_security_group.security_group.name
    ]
	
	tags = {
		Name 		= 	"k8s-master-kul"
	}
	
	provisioner "remote-exec" {
	
		connection {
			type = "ssh"
			user = "root"
			password = "thinknyx@123"
			host = self.public_ip
		}
		inline = [
			"sudo hostnamectl set-hostname master",
			"sudo yum install -y wget",
			"sudo wget https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm",
			"sudo yum install -y ansible",
			"sudo echo '[master]' >> /etc/ansible/hosts",
			"sudo echo ${self.public_ip} >> /etc/ansible/hosts",
			"sudo echo '${self.private_ip} master' >> /etc/hosts"
		]
	}
	
	provisioner "local-exec" {
		command = "echo ${self.public_ip} > public_ip"
	}
}
    