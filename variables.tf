variable "region" {
  description = "AWS region"
  type        = string
}

variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "List of private subnet CIDR blocks"
  type        = list(string)
  default     = [
    "10.0.1.0/24",  # eu-central-1a
    "10.0.2.0/24",  # eu-central-1b
    "10.0.3.0/24"   # eu-central-1c
    ]
}

variable "public_subnet_cidrs" {
  description = "List of public subnet CIDR blocks"
  type        = list(string)
  default     = [
    "10.0.101.0/24",  # eu-central-1a
    "10.0.102.0/24",  # eu-central-1b
    "10.0.103.0/24"   # eu-central-1c
    ]
}


variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "cluster_version" {
  description = "Kubernetes version for the EKS cluster"
  type        = string
}

variable "node_group_min_size" {
  description = "Minimum size of the EKS node group"
  type        = number
}

variable "node_group_max_size" {
  description = "Maximum size of the EKS node group"
  type        = number
}

variable "node_group_desired_size" {
  description = "Desired size of the EKS node group"
  type        = number
}

variable "node_group_instance_types" {
  description = "List of instance types for the EKS node group"
  type        = list(string)
}

variable "ecr_repository_name" {
  description = "Name of the ECR repository"
  type        = string
}

variable "elasticache_name" {
  description = "Name of the ElastiCache cluster"
  type        = string
}

variable "elasticache_cluster_size" {
  description = "Number of nodes in the ElastiCache cluster"
  type        = number
  default     = 3
}

variable "elasticache_instance_type" {
  description = "Instance type for ElastiCache nodes"
  type        = string
}

variable "elasticache_engine_version" {
  description = "Redis engine version for ElastiCache"
  type        = string
}

variable "elasticache_family" {
  description = "Redis parameter group family"
  type        = string
}

variable "elasticache_subnet_cidrs" {
  description = "ElastiCache subnet"
  type        =   type        = list(string)
  default     = [
    "10.0.30.1/24",  # eu-central-1a
    "10.0.30.2/24",  # eu-central-1b
    "10.0.30.3/24"   # eu-central-1c
    ]}

variable "s3_bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
}

variable "domain_name" {
  description = "Domain name for Route53"
  type        = string
}

variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "kubernetes_namespace" {
  description = "Kubernetes namespace"
  type        = string
}

variable "app_name" {
  description = "Name of the application"
  type        = string
}

variable "app_replicas" {
  description = "Number of application replicas"
  type        = number
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}