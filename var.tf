# INPUT VARIABLES
# AWS Region
variable "aws_region" { 
    description = "This is the region where the AWS resource would be created"
    type = string
    default = "us-west-1"

}

# AWS EC2 Instance Type
variable "instance_type" {
    description = "EC2 Instance type"
    type = string
    default = "t2.medium" //"t2.micro"    //"t2.small" //"t2.medium"
 }


# AWS EC2 Instance Key Pair
variable "key-name" { 
    description = "Key pair that needs to be associated to EC2 instance"
    type = string
    default = "calkeypair"

}

variable "instance_type_list" {
  description = "EC2 instance type"
  type = list(string)
  default = ["t2.micro", "t3.micro", "t3.small" ]
}

variable "cluster_name" {
  type = string
  default = "erply"
}

variable "kubernetes_version" {
  type    = string
  default = "1.29"
}