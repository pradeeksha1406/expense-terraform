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

#module "public-lb" {
#  source = "./modules/alb"
#  alb_sg_allow_cidr = "0.0.0.0/0"
#  alb_type = "public"
#  env = var.env
#  internal = false
#  subnets = module.vpc.public_subnets
#  vpc_id = module.vpc.vpc_id
#}
#
module "private-lb" {
  source = "./modules/alb"
  alb_sg_allow_cidr = var.vpc_cidr
  alb_type = "private"
  env = var.env
  internal = true
  subnets = module.vpc.private_subnets
  vpc_id = module.vpc.vpc_id
  dns_name = "backend-${var.env}.techadda.co"
  zone_id = "Z02181513KJGBXLJM7332"
  tg_arn = module.backend.tg_arn
}

module "frontend" {
  source = "./modules/app"
  app_port = "80"
  component = "frontend"
  env = var.env
  instance_type = "t3.micro"
  vpc_cidr = var.vpc_cidr
  vpc_id = module.vpc.vpc_id
  subnets = module.vpc.private_subnets
  bastion_node_cidr = var.bastion_node_cidr
}

module "backend" {
  depends_on = [module.mysql]
  source = "./modules/app"
  app_port = "8080"
  component = "backend"
  env = var.env
  instance_type = "t3.micro"
  vpc_cidr = var.vpc_cidr
  vpc_id = module.vpc.vpc_id
  subnets = module.vpc.private_subnets
  bastion_node_cidr = var.bastion_node_cidr
}

module "mysql" {
  source = "./modules/rds"
  component = "mysql"
  env = var.env
  subnets = module.vpc.private_subnets
  vpc_cidr = var.vpc_cidr
  vpc_id = module.vpc.vpc_id
}