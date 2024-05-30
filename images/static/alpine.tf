module "alpine" {
  providers = {
    apko = apko.alpine
  }
  source  = "chainguard-dev/apko/publisher"
  version = "0.0.12"

  target_repository = var.target_repository
  config            = file("${path.module}/configs/alpine.apko.yaml")
  extra_packages    = [] # Override the default, which includes `wolfi-baselayout`
  check_sbom        = false
}

module "test-alpine" {
  source = "./tests"
  digest = module.alpine.image_ref
}
