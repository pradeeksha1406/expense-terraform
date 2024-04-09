env = "dev"

vpc_cidr             = "10.0.0.0/16"

public_subnets       = ["10.0.0.0/24" , "10.0.1.0/24"]
private_subnets      = ["10.0.2.0/24" , "10.0.3.0/24"]
azs                  = ["us-east-1a" , "us-east-1b"]
default_vpc_id       = "vpc-08e0ae2726a009f82"
account_no           = "851725420695"
default_vpc_cidr     = "172.31.0.0/16"
default-route-table_id = "rtb-0f913a4882745f512"
bastion_node_cidr      = [ "172.31.95.42/32" ]
desired_capacity       = 1
max_size               = 1
min_size               = 1
instance_class         = "db.t3.medium"
prometheus_cidr        = [ "172.31.34.169/32" ]


