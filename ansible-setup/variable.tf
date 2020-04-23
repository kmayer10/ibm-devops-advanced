variable "master_instance_type" {
	default = "t2.micro"
}

variable "master_instance_count" {
	default = 1
}

variable "node_instance_type" {
	default = "t2.micro"
}

variable "node_instance_count" {
	default = 1
}

variable "name" {
	default = "ansible-setup"
}