module "alpine" { source = "./config/alpine" }

module "latest-alpine" {
  providers = {
    apko = apko.alpine
  }
  source = "../../tflib/publisher"

  target_repository = var.target_repository
  config            = module.alpine.config
  # Override the module's default wolfi packages that conflict with alpine
  extra_packages = []
}

module "test-latest-alpine" {
  source = "./tests"
  digest = module.latest-alpine.image_ref
}
