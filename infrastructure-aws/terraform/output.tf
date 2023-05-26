output "vpc_id" {
    value = module.vpc.vpc.id
}
output "serverPublic_ip" {
    value = module.ec2.server_public_ip
}
output "serverPrivate_ip" {
    value = module.ec2.server_private_ip
}
# output "serverPublic_ip_2" {
#     value = module.ec2.server_public_ip_2
# }
# output "serverPrivate_ip_2" {
#     value = module.ec2.server_private_ip_2
# }
output "applicationLoadBalancerDnsName" {
  value = module.alb.application_load_balancer_dns_name
}