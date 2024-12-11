terraform {
  required_providers {
    apko = {
      source                = "chainguard-dev/apko"
      configuration_aliases = [apko.alpine]
    }
    oci = { source = "chainguard-dev/oci" }
  }
}

variable "target_repository" {
  description = "The docker repo into which the image and attestations should be published."
}

module "latest" {
  providers = { apko = apko.alpine }

  source  = "chainguard-dev/apko/publisher"
  version = "0.0.17"

  target_repository = var.target_repository
  config            = file("${path.module}/configs/latest.apko.yaml")
  extra_packages    = [] # The default pulls in alpine-baselayout which cannot be used in alpine
}

module "test-latest" {
  source = "./tests"
  digest = module.latest.image_ref
}

resource "oci_tag" "version-tags" {
  depends_on = [module.test-latest]
  digest_ref = module.latest.image_ref
  tag        = "latest"
}
