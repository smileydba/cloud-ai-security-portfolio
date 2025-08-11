module "network" {
  source         = "./modules/network"
  name_prefix    = var.name_prefix
  vpc_cidr       = var.vpc_cidr
  public_subnets = var.public_subnets
}

module "security" {
  source           = "./modules/security"
  name_prefix      = var.name_prefix
  vpc_id           = module.network.vpc_id
  allowed_ssh_cidr = var.allowed_ssh_cidr
}

# Use first public subnet for the web server
module "web_server" {
  source            = "./modules/web_server"
  name_prefix       = var.name_prefix
  subnet_id         = module.network.public_subnet_ids[0]
  security_group_id = module.security.security_group_id
  instance_type     = var.instance_type
  key_name          = var.key_name
}
