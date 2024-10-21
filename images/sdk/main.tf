terraform {
  required_providers {
    apko = {
      source                = "chainguard-dev/apko"
      configuration_aliases = [apko.local]
    }
    oci = { source = "chainguard-dev/oci" }
  }
}

variable "target_repository" {
  description = "The docker repo into which the image and attestations should be published."
}

module "latest" {
  providers = { apko = apko.local }
  source    = "chainguard-dev/apko/publisher"
  version   = "0.0.15"

  target_repository = var.target_repository
  config            = file("${path.module}/configs/latest.apko.yaml")
  check_sbom        = false // chainctl doesn't use SPDX compliant license
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
