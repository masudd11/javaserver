# creating vpc
resource "aws_vpc" "test-vpc" {
  cidr_block           = "10.0.0.0/26"
  instance_tenancy     = "default"
  enable_dns_hostnames = "true"
  enable_dns_support   = "true"
  tags = {
    "Name" = "test-vpc"
  }
}
#  creating public-subnet
resource "aws_subnet" "public-subnet" {
  vpc_id                  = aws_vpc.test-vpc.id
  map_public_ip_on_launch = "true"
  availability_zone       = "ap-south-1a"
  cidr_block              = "10.0.0.0/26"
  tags = {
    "Name" = "public-subnet"
  }
}

# creating internate-gateway
resource "aws_internet_gateway" "firstigw" {
  vpc_id = aws_vpc.test-vpc.id
  tags = {
    "Name" = "firstigw"
  }
}

# Creating Route Tables for Internet gateway
resource "aws_route_table" "first-publicroute" {
  vpc_id = aws_vpc.test-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.firstigw.id
  }

  tags = {
    Name = "first-publicroute"
  }
}

# Creating Route Associations public subnets
resource "aws_route_table_association" "first-public" {
  subnet_id      = aws_subnet.public-subnet.id
  route_table_id = aws_route_table.first-publicroute.id
}