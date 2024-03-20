module "vpc" {
  source = "./modules/vpc"
  vpc_cidr = var.vpc_cidr
  env = var.env
  private_subnets = var.private_subnets
  public_subnets = var.public_subnets
  azs = var.azs
  account_no = var.account_no
  default_vpc_id = var.default_vpc_id
  default_vpc_cidr = var.default_vpc_cidr
  default-route-table_id = var.default-route-table_id

}

module "public-lb" {
  source = "./modules/alb"
  alb_sg_allow_cidr = "0.0.0.0/0"
  alb_type = "public"
  env = var.env
  internal = false
  subnets = module.vpc.public_subnets
  vpc_id = module.vpc.vpc_id
}
