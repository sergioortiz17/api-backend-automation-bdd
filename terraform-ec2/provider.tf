provider "aws" {
  region  = var.aws_region
  profile = "default"  # O el perfil que usaste en AWS CLI
}