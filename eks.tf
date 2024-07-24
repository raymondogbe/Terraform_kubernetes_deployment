


/*module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "19.13.1"

  cluster_name    = erply_kubernetes
  cluster_version = "1.24"

  vpc_id     = aws_vpc.vpc_prod.id
  subnet_ids = module.vpc.private_subnets
  cluster_endpoint_public_access = true

  eks_managed_node_group_defaults = {
    ami_type = "AL2_x86_64"

  }


  eks_managed_node_groups = {
    one = {
      name = "node-group-1"

      instance_types = ["t3.small"]

      min_size     = 1
      max_size     = 3
      desired_size = 2
    }

    two = {
      name = "node-group-2"

      instance_types = ["t3.small"]

      min_size     = 1
      max_size     = 2
      desired_size = 1
    }
  }
} 



resource "aws_eks_cluster" "k8s" {
  name     = "k8s-cluster"
  role_arn = aws_iam_role.eks_cluster_role.arn

  vpc_config {
    subnet_ids = [aws_subnet.subnet.id]
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster_AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.eks_cluster_AmazonEKSServicePolicy
  ]
}

*/


/*
##########################################################
# IAM role for eks

resource "aws_iam_role" "erply_role" {
  name = "erply_kubernetes"

  assume_role_policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": [
                    "eks.amazonaws.com"
                ]
            },
            "Action": "sts:AssumeRole"
        }
    ]
}
POLICY
}

# eks policy attachment

resource "aws_iam_role_policy_attachment" "erply-AmazonEKSClusterPolicy" {
  role       = aws_iam_role.erply_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

# bare minimum requirement of eks

resource "aws_eks_cluster" "erply" {
  //name     = "erply"
  name     = var.cluster_name
  version  = var.kubernetes_version
  role_arn = aws_iam_role.erply_role.arn

  vpc_config {
    subnet_ids = [
      aws_subnet.vpc_prod_subnet1.id,
      aws_subnet.vpc_prod_subnet2.id,
      aws_subnet.vpc_prod_subnet3.id,
      aws_subnet.vpc_prod_subnet4.id
    ]
  }

  depends_on = [aws_iam_role_policy_attachment.erply-AmazonEKSClusterPolicy]
}


# role for nodegroup

resource "aws_iam_role" "nodes" {
  name = "eks-node-group-nodes"

  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}

# IAM policy attachment to nodegroup

resource "aws_iam_role_policy_attachment" "nodes-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.nodes.name
}


resource "aws_iam_role_policy_attachment" "nodes-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.nodes.name
}

resource "aws_iam_role_policy_attachment" "nodes-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.nodes.name
}


# aws node group 

resource "aws_eks_node_group" "private-nodes" {
  cluster_name    = aws_eks_cluster.erply.name
  node_group_name = "private-nodes"
  node_role_arn   = aws_iam_role.nodes.arn

  subnet_ids = [
    aws_subnet.vpc_prod_subnet2.id,
    aws_subnet.vpc_prod_subnet4.id
  ]

  capacity_type  = "ON_DEMAND"
  instance_types = ["t2.medium"]

  scaling_config {
    desired_size = 1
    max_size     = 3
    min_size     = 1
  }

  update_config {
    max_unavailable = 1
  }

  labels = {
    node = "general"
  }


  # taint {
  #   key    = "team"
  #   value  = "devops"
  #   effect = "NO_SCHEDULE"
  # }

  # launch_template {
  #   name    = aws_launch_template.eks-with-disks.name
  #   version = aws_launch_template.eks-with-disks.latest_version
  # }

  depends_on = [
    aws_iam_role_policy_attachment.nodes-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.nodes-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.nodes-AmazonEC2ContainerRegistryReadOnly,
  ]
}

# launch template if required

# resource "aws_launch_template" "eks-with-disks" {
#   name = "eks-with-disks"

#   key_name = "local-provisioner"

#   block_device_mappings {
#     device_name = "/dev/xvdb"

#     ebs {
#       volume_size = 50
#       volume_type = "gp2"
#     }
#   }
# }


#######################################

*/

/*
resource "aws_eks_cluster" "k8s" {
  name     = "k8s-cluster"
  role_arn = aws_iam_role.eks_cluster_role.arn

  vpc_config {
    subnet_ids = [aws_subnet.vpc_prod_subnet1.id,
    aws_subnet.vpc_prod_subnet2.id,
    aws_subnet.vpc_prod_subnet3.id,
    aws_subnet.vpc_prod_subnet4.id]
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster_AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.eks_cluster_AmazonEKSServicePolicy
  ]
}


*/

/*

// Define an IAM role for the EKS cluster control plane
resource "aws_iam_role" "eks_cluster" {
  name = "eks-cluster"

  // Specify the permissions for assuming this role
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

// Attach AmazonEKSClusterPolicy to the IAM role created for EKS cluster
resource "aws_iam_role_policy_attachment" "AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks_cluster.name
}

// Attach AmazonEKSServicePolicy to the IAM role created for EKS cluster
resource "aws_iam_role_policy_attachment" "AmazonEKSServicePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  role       = aws_iam_role.eks_cluster.name
}

// Create an EKS cluster
resource "aws_eks_cluster" "aws_eks" {
  name     = "erply" //"eks_cluster_demo"
  role_arn = aws_iam_role.eks_cluster.arn

  // Configure VPC for the EKS cluster
  vpc_config {
    subnet_ids = [
      aws_subnet.vpc_prod_subnet1.id,
      aws_subnet.vpc_prod_subnet2.id,
      aws_subnet.vpc_prod_subnet3.id,
      aws_subnet.vpc_prod_subnet4.id
    ]
  }

  // Add tags to the EKS cluster for identification
  tags = {
    Name = "EKS_demo"
  }
}

// Define an IAM role for EKS worker nodes
resource "aws_iam_role" "eks_nodes" {
  name = "eks-node-group-demo"

  // Specify the permissions for assuming this role
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

// Attach AmazonEKSWorkerNodePolicy to the IAM role created for EKS worker nodes
resource "aws_iam_role_policy_attachment" "AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.eks_nodes.name
}

// Attach AmazonEKS_CNI_Policy to the IAM role created for EKS worker nodes
resource "aws_iam_role_policy_attachment" "AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.eks_nodes.name
}

// Attach AmazonEC2ContainerRegistryReadOnly to the IAM role created for EKS worker nodes
resource "aws_iam_role_policy_attachment" "AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.eks_nodes.name
}

// Create an EKS node group
resource "aws_eks_node_group" "node" {
  cluster_name    = aws_eks_cluster.aws_eks.name
  node_group_name = "node_demo"
  node_role_arn   = aws_iam_role.eks_nodes.arn
  subnet_ids = [
    aws_subnet.vpc_prod_subnet2.id,
    aws_subnet.vpc_prod_subnet4.id
  ]

  // Configure scaling options for the node group
  scaling_config {
    desired_size = 1
    max_size     = 2
    min_size     = 1
  }

  // Ensure that the creation of the node group depends on the IAM role policies being attached
  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,
  ]
}
*/
