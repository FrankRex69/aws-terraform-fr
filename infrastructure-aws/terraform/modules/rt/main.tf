# 3. Create Custom Route Table
resource "aws_route_table" "prod-route-table" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.gatewayId
  }

  route {
    ipv6_cidr_block = "::/0"
    gateway_id      = var.gatewayId
  }

  tags = {
    Name = "Prod"
  }
}