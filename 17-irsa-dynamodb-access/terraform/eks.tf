module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 21.0"

  name               = "irsa-cluster"
  kubernetes_version = "1.31"

  endpoint_public_access = true

  enable_cluster_creator_admin_permissions = true

  vpc_id = aws_vpc.main.id

  subnet_ids = [
    aws_subnet.public_a.id,
    aws_subnet.public_b.id
  ]

  addons = {
    coredns = {}

    kube-proxy = {}

    vpc-cni = {}
  }

  eks_managed_node_groups = {
    main = {
      instance_types = ["t3.medium"]

      min_size     = 2
      max_size     = 2
      desired_size = 2

      ami_type = "AL2023_x86_64_STANDARD"
    }
  }

  tags = {
    Environment = "dev"
    Project     = "irsa-demo"
  }
}