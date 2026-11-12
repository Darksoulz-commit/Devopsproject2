
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.13.0"

  # VPC Configuration
  name = local.name
  cidr = local.vpc_cidr

  # Availability Zones
  azs = local.azs

  # Subnet Configuration
  public_subnets  = local.public_subnets
  private_subnets = local.private_subnets
  intra_subnets   = local.intra_subnets

  # NAT Gateway Configuration
  enable_nat_gateway = true
  single_nat_gateway = true

  # DNS Configuration
  enable_dns_hostnames = true
  enable_dns_support   = true

  # Public Subnet Tags
  public_subnet_tags = {
    "kubernetes.io/role/elb" = "1"
    Type                     = "Public"
  }

  # Private Subnet Tags
  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = "1"
    Type                               = "Private"
  }

  # Intra Subnet Tags
  intra_subnet_tags = {
    Type = "Intra"
  }

  # VPC Tags
  tags = local.tags
}
