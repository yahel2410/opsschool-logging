output "public_ip" {
  value = module.ec2-instance.public_ip[0]
}
output "private_ip" {
  value = module.ec2-instance.private_ip[0]
}


output "ssh_cmd" {
  value = "ssh ubuntu@${module.ec2-instance.public_ip[0]}"
}
output "kibana_url" {
  value = "http://${module.ec2-instance.public_ip[0]}:5601"
}
