variable "vpc_cidr" {
  description = "VPC CIDR Range"
  type        = string
}
variable "subnet_cidr" {
  type        = list(string)
  description = "Subnet CIDRS"
}