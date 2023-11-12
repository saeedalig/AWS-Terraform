# VPC
module "VPC" {
  source        = "./modules/VPC"
  vpc_cidr      = var.vpc_cidr
  public_cidrs  = var.public_cidrs
  private_cidrs = var.private_cidrs
}


# EC2
module "EC2" {
  source        = "./modules/EC2"
  ami_id        = "ami-0287a05f0ef0e9d9a" # ap-south-1
  instance_type = var.instance_type
  subnet_id     = module.VPC.public_subnet_ids[0]

}

# NAT
module "NAT" {
  source        = "./modules/NAT"
  public_cidrs  = module.VPC.public_subnet_ids
  private_cidrs = module.VPC.private_subnet_ids
  igw_id        = module.VPC.igw_id
  vpc_id        = module.VPC.vpc_id

}

# Security Group
module "SECURITY-GROUP" {
  source = "./modules/Security-Group"
  vpc_id = module.VPC.vpc_id
}