#This is what the terraform apply would showcase after it finish running. 
# For each does not support splat, therefore, you should use list.

output "instance_publicIP_list" {
  description = "EC2 instance Public IP"
  value = [for instance in aws_instance.ERPLY: instance.public_ip] 
  #aws_instance.ERPLY.public_ip
}

output "instance_publicDNS_map" {
  description = "EC2 instance Public DNS"
  #value = [for instance in aws_instance.ERPLY: instance.public_dns]
  #value = aws_instance.ERPLY.public_dns
  value = aws_instance.ERPLY[*].public_dns
}
