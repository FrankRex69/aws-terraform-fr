# Output
output "server_public_ip" {
    value = aws_instance.web-server-instance.public_ip
}
output "server_private_ip" {
    value = aws_instance.web-server-instance.private_ip
}
output "server_public_ip_2" {
    value = aws_instance.web-server-instance-b.public_ip
}
output "server_private_ip_2" {
    value = aws_instance.web-server-instance-b.private_ip
}