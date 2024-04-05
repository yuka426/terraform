module "app" {
  source         = "./modules/app"
  subnet_ids     = module.network.subnet_ids
  iam_roles_arn  = module.iam.iam_roles_arn
  vpc_id         = module.network.vpc_id
  aws_account_id = module.iam.aws_account_id
}

# module "iam" {
#   source              = "../../modules/iam"
#   aws                 = var.aws
#   codepipeline_bucket = module.cicd.codepipeline_bucket
# }

module "network" {
  source = "../../modules/network"
}

# module "cicd" {
#   source        = "../../modules/cicd"
#   iam_roles_arn = module.iam.iam_roles_arn
#   tags          = var.tags
# }



