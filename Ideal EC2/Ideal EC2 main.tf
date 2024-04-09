# Terraform configuration for creating an Amazon EKS cluster for Ideal Software

# Define provider configuration
provider "aws" {
  region = "us-east-2"  # Specify the AWS region
}

# Define the EKS cluster
resource "aws_eks_cluster" "ideal_eks_cluster" {
  name     = "IdealSoftwareCluster"  # Specify the name of the EKS cluster
  role_arn = "arn:aws:iam::946262894364:role/IdealSoftwareClusterRoleEKS"  # Specify the IAM role ARN for the EKS cluster
  version  = "1.29"  # Specify the Kubernetes version

  # Specify the VPC configuration
  vpc_config {
    subnet_ids         = ["subnet-0b22ad77de589552a", "subnet-0647476bc212b72d3"]  # Specify the subnet IDs
    security_group_ids = ["sg-05da67a8cf1f2d06a"]  # Update the security group ID
  }
}

# Define the EKS node group
resource "aws_eks_node_group" "ideal_node_group" {
  cluster_name    = aws_eks_cluster.ideal_eks_cluster.name
  node_group_name = "IdealSoftwareNodeGroup"  # Specify the name for the node group
  node_role_arn   = aws_eks_cluster.ideal_eks_cluster.role_arn  # Use the same IAM role ARN for the nodes as the cluster
  subnet_ids      = ["subnet-0b22ad77de589552a", "subnet-0647476bc212b72d3"]  # Specify the subnet IDs
  instance_types  = ["t2.micro"]  # Specify the instance types
  scaling_config {
    desired_size = 1
    max_size     = 2
    min_size     = 1
  }
}

# Output the EKS cluster details
output "ideal_cluster_endpoint" {
  value       = aws_eks_cluster.ideal_eks_cluster.endpoint
  description = "The endpoint for the Ideal Software EKS cluster."
}

output "ideal_cluster_certificate_authority_data" {
  value       = aws_eks_cluster.ideal_eks_cluster.certificate_authority.0.data
  description = "The base64 encoded certificate data required to communicate with the Ideal Software EKS cluster."
}
