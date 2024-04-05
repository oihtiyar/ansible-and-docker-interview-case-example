output "vpc_id" {
    value = aws_vpc.oi-dev-vpc.id
}

output "subnet_ids" {
    value = aws_subnet.subnets.*.id
}