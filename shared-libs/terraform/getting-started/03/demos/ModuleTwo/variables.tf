variable "region" {
  description = "AWS region to deploy into"
  type        = string
  default     = "us-east-1"
}

variable "name_prefix" {
  description = "Prefix used for resource names"
  type        = string
  default     = "tf-nginx"
}

variable "vpc_cidr" {
  description = "VPC CIDR"
  type        = string
  default     = "10.1.0.0/16"
}

variable "public_subnets" {
  description = "Public subnet CIDRs (will be spread across AZs)"
  type        = list(string)
  default     = ["10.1.0.0/24", "10.1.1.0/24"]
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
  validation {
    condition     = contains(["t3.micro","t4g.micro"], var.instance_type)
    error_message = "Use t3.micro (x86) or t4g.micro (ARM) for Free Tier in this demo."
  }
}


variable "key_name" {
  description = "Existing EC2 key pair name for SSH; set null to disable"
  type        = string
  default     = null
}

variable "allowed_ssh_cidr" {
  description = "CIDR allowed for SSH (lock this to your IP in real life)"
  type        = string
  default     = "0.0.0.0/0"
}
