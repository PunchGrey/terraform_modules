output "test_public_subnet_id" {
  value = aws_subnet.test_public[*].id
}

output "vpc_id" {
  value = aws_vpc.name.id
}