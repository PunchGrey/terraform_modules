/*
variable "region" {
  type = string
  default = "eu-west-1"
  description = "aws region"
}

variable "profile" {
  type = string
  default = "terraform"
  description = "profile in aws config"
}
*/

variable "cidr_block_vpc" {
  type = string
  default = "10.0.0.0/16"
  description = "sider block for vpc"
}

variable "vpc_name" {
  type = string
  default = "my-vpc-dev"
  description = "vpc name"
}

variable "env" {
  type = string
  default = "dev"
  description = "environment name"
}

variable "public_subnet_cidr" {
  type = list
  default = ["10.0.0.0/24","10.0.1.0/24"]
  description = "list ciderblocks for public subnets"
}

variable "private_subnet_cidr" {
  type = list
  default = ["10.0.50.0/24","10.0.51.0/24"]
  description = "list ciderblocks for private subnets"
}