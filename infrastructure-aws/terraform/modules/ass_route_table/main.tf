# 5. Associate subnet with Route Table
resource "aws_route_table_association" "a" {
  subnet_id      = var.subnetId
  route_table_id = var.routeTable_id
}

resource "aws_route_table_association" "b" {
  subnet_id      = var.subnetId_1b
  route_table_id = var.routeTable_id
}