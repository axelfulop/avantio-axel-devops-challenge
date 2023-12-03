module "avantio-vpc" {
    source = "../../modules/vpc"
    region = var.region
    env = var.env
}