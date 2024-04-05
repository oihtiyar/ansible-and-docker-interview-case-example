resource "aws_instance" "centos_instance" {
  ami           = var.instance_ami_name
  instance_type = var.instance_type
  key_name      = var.key_name
  vpc_security_group_ids = var.vpc_security_group_ids
  subnet_id = var.subnet_id
  user_data = file("ansible.sh")

  
  #vpc_security_group_ids = [module.sg.sg_id]

  tags = {
    Name = "centos 7"
  }
}

output "instance_ip" {
  value = aws_instance.centos_instance.public_ip
}