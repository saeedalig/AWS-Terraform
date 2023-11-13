# Create VPC Module
module "vpc" {
  source        = "../modules/vpc"
  name          = var.name
  vpc_cidr      = var.vpc_cidr
  pub_sub-cidrs = var.pub_sub-cidrs
  pri_sub-cidrs = var.pri_sub-cidrs
  db_sub_cidrs  = var.db_sub_cidrs
}

# Create NAT Gateway Module
module "nat" {
  source      = "../modules/nat"
  name        = module.vpc.name
  vpc_id      = module.vpc.vpc_id
  pub_sub_ids = module.vpc.pub_sub_ids
  pri_sub_ids = module.vpc.pri_sub_ids
  db_sub_ids  = module.vpc.db_sub_ids
  igw_id      = module.vpc.igw_id

}

# Create Security Group Module
module "security_group" {
  source = "../modules/security-group"
  name   = module.vpc.name
  vpc_id = module.vpc.vpc_id

}