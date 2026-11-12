
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "19.15.1"

  # EKS Cluster Configuration
  cluster_name = local.name

  cluster_endpoint_public_access  = true
  cluster_endpoint_private_access = true

  # EKS Cluster Addons
  cluster_addons = {
    coredns = {
      most_recent = true
    }

    kube-proxy = {
      most_recent = true
    }

    vpc-cni = {
      most_recent = true
    }
  }

  # VPC Configuration
  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  # EKS Managed Node Group
  eks_managed_node_groups = {
    zero-node = {
      name = "Zero-Node"

      min_size     = 2
      max_size     = 4
      desired_size = 2

      # EC2 Instance Configuration
      instance_types = ["c7i-flex.large"]
      capacity_type  = "SPOT"

      # Node Labels
      labels = {
        role = "worker"
        Name = "Zero_Node"
      }

      # Node Group Tags
      tags = {
        Name     = "Zero_Node"
        ExtraTag = "Zero_Node"
        Project  = "DevOps-Project-2"
      }
    }
  }

  # Common Tags
  tags = {
    Project     = "DevOps-Project-2"
    Environment = "Development"
    ManagedBy   = "Terraform"
  }
}
