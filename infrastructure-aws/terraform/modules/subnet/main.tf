# 4. Create a Subnet 

resource "aws_subnet" "subnet-1" {
  vpc_id            = var.vpc_id
  cidr_block        = "10.0.1.0/24"
  availability_zone = var.availabilityzone

  tags = {
    Name = "prod-subnet"
  }
}

resource "aws_subnet" "subnet-1b" {
  vpc_id            = var.vpc_id
  cidr_block        = "10.0.2.0/24"
  availability_zone = var.availabilityzone_b

  tags = {
    Name = "prod-subnet-1b"
  }
}