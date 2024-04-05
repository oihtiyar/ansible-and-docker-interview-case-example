variable "instance_ami_name" {
  description = "AMI name for the EC2 instance"
  type        = string
}
variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "key_name" {
  description = "Key pair name for SSH access"
  type        = string
}

variable "vpc_security_group_ids" {
  description = "A list of security group IDs to associate with"
  type        = list(string)
  #default     = ""
}

variable "subnet_id" {
  description = "User data script for EC2 instance"
  type        = string
  default     = ""
}