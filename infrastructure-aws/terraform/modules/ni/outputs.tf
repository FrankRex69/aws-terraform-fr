output "network_interface_id" {
    value = aws_network_interface.web-server-nic.id
}

output "network_interface_id_b" {
    value = aws_network_interface.web-server-nic-b.id
}