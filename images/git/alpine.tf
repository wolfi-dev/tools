module "alpine" {
  for_each           = local.accounts
  source             = "./config"
  root               = each.key == "root"
  extra_repositories = ["https://dl-cdn.alpinelinux.org/alpine/edge/community"]
}

module "latest-alpine" {
  providers = {
    apko = apko.alpine
  }
  for_each          = local.accounts
  source            = "../../tflib/publisher"
  target_repository = var.target_repository
  config            = module.alpine[each.key].config
  extra_packages    = [] // Don't add wolfi-baselayout
}

module "test-latest-alpine" {
  for_each = local.accounts
  source   = "./tests"
  digest   = module.latest-alpine[each.key].image_ref
}
