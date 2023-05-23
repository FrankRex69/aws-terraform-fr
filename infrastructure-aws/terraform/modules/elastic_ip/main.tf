# 8. Assign an elastic IP to the network interface created in step 7
resource "aws_eip" "one" {
  vpc                       = true
  network_interface         = var.networkinterface
  associate_with_private_ip = "10.0.1.50"
  depends_on                = [var.internet_gateway]
}

resource "aws_eip" "two" {
  vpc                       = true
  network_interface         = var.networkinterface_b
  associate_with_private_ip = "10.0.2.50"
  depends_on                = [var.internet_gateway]
}