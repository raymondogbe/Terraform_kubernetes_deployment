terraform {
  #required_version = "1.5.4"    # Here is the terraform block which was introduced from version 0.13 and upwards
  required_providers {
    aws = {     #Argument opens with =, while block opens with {
      source  = "hashicorp/aws"
      version = "5.29.0"
    }
  }
}
  
provider "aws" {
  profile = "default" 
  region = var.aws_region
}

/*
data "aws_eks_cluster" "default" {
  name = var.cluster_name
}

data "aws_eks_cluster_auth" "default" {
  name = var.cluster_name
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.default.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.default.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.default.token
}
*/