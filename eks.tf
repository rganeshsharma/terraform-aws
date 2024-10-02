# eks.tf

module "eks_al2" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version

  # EKS Addons
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
    aws-ebs-csi-driver = {
      most_recent = true
    }
    eks-pod-identity-agent = {
      most_recent = true
    }
  }

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  eks_managed_node_groups = {
    cms = {
      name = "cms-node-group"
      ami_type = "AL2_x86_64"
      instance_types = ["m6i.large"]
      min_size     = 2
      max_size     = 5
      desired_size = 2
      
      labels = {
        name = "cms"
      }

      taints = {
        dedicated = {
          key    = "dedicated"
          value  = "cms"
          effect = "NO_SCHEDULE"
        }
      }

      block_device_mappings = {
        xvda = {
          device_name = "/dev/xvda"
          ebs = {
            volume_size           = 50
            volume_type           = "gp3"
            encrypted             = true
            kms_key_id            = aws_kms_key.ebs.arn
            delete_on_termination = false
          }
        }
      }
    }
    
    backend = {
      name = "backend-node-group"
      ami_type = "AL2_x86_64"
      instance_types = ["m6i.large"]
      min_size     = 2
      max_size     = 5
      desired_size = 2
      
      labels = {
        name = "backend"
      }
    }
  }

  tags = local.tags
}

# KMS key for EBS encryption
resource "aws_kms_key" "ebs" {
  description             = "KMS key for EBS encryption"
  deletion_window_in_days = 7
  enable_key_rotation     = true

  tags = merge(
    local.tags,
    {
      Name = "${cluster_name.name}-ebs-encryption-key"
    }
  )
}

resource "aws_kms_alias" "ebs" {
  name          = "alias/${local.name}-ebs-encryption-key"
  target_key_id = aws_kms_key.ebs.key_id
}