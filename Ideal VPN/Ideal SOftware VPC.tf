provider "aws" {
  region = "us-east-2"
}

resource "aws_vpc" "ideal_vpc" {
  cidr_block = "10.0.0.0/20"
}

resource "aws_subnet" "public_subnet" {
  vpc_id            = aws_vpc.ideal_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-2a"
}

resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.ideal_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-2b"
}

output "vpc_id" {
  value = aws_vpc.ideal_vpc.id
}

output "public_subnet_id" {
  value = aws_subnet.public_subnet.id
}

output "private_subnet_id" {
  value = aws_subnet.private_subnet.id
}
