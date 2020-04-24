provider "aws" {
	region = "us-east-1"
}


resource "aws_instance" "ansible-node" {
	ami           	= 	"ami-030ff268bd7b4e8b5"
	instance_type 	= 	"t2.medium"
	key_name		= 	"Kul-Thinknyx"
		
	tags = {
		Name 		= 	"ansible-node-kul"
	}	
}