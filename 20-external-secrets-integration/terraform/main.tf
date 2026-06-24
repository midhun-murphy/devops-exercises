module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  name = "exercise20-vpc"
  cidr = "10.0.0.0/16"

  azs = [
    "ap-south-1a",
    "ap-south-1b"
  ]

  private_subnets = [
    "10.0.1.0/24",
    "10.0.2.0/24"
  ]

  public_subnets = [
    "10.0.101.0/24",
    "10.0.102.0/24"
  ]

  enable_dns_hostnames = true
  enable_dns_support   = true

  enable_nat_gateway = true
  single_nat_gateway = true

  public_subnet_tags = {
    "kubernetes.io/role/elb"               = 1
    "kubernetes.io/cluster/exercise20-eks" = "shared"
  }

  private_subnet_tags = {
    "kubernetes.io/role/internal-elb"      = 1
    "kubernetes.io/cluster/exercise20-eks" = "shared"
  }

  tags = {
    Terraform = "true"
    Project   = "external-secrets"
  }
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 21.0"

  name               = "exercise20-eks"
  kubernetes_version = "1.31"

  endpoint_public_access  = true
  endpoint_private_access = false

  authentication_mode = "API_AND_CONFIG_MAP"

  enable_cluster_creator_admin_permissions = true

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  eks_managed_node_groups = {
    default = {
      instance_types = ["t3.medium"]

      ami_type = "AL2_x86_64"

      min_size     = 1
      max_size     = 2
      desired_size = 1

      disk_size = 20

      capacity_type = "ON_DEMAND"

      labels = {
        role = "general"
      }
      tags = {
        Name = "exercise20-worker"
      }

    }
  }

  tags = {
    Environment = "lab"
    Project     = "external-secrets"
  }
}
