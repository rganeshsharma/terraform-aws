module "alb_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 4.0"

  name        = "${var.project_name}-alb-sg"
  description = "Security group for ALB"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["http-80-tcp", "https-443-tcp"]
  egress_rules        = ["all-all"]

  tags = var.tags
}

module "eks_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 5.2.0"

  name        = "${var.project_name}-eks-sg"
  description = "Security group for EKS cluster"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks = [module.vpc.vpc_cidr_block]
  ingress_rules       = ["https-443-tcp"]
  egress_rules        = ["all-all"]

  tags = var.tags
}