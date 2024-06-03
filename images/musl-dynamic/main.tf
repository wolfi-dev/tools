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
  source    = "chainguard-dev/apko/publisher"
  version   = "0.0.15"

  target_repository = var.target_repository
  config            = file("${path.module}/configs/latest.apko.yaml")
  extra_packages    = [] # The default pulls in wolfi-baselayout which cannot be used in alpine
}

module "test-latest" {
  source = "./tests"
  digest = module.latest.image_ref
}

module "version-tags" {
  source  = "../../tflib/version-tags"
  package = "musl"
  config  = module.latest.config
}

resource "oci_tag" "version-tags" {
  depends_on = [module.test-latest]
  for_each   = toset(concat(["latest"], module.version-tags.tag_list))
  digest_ref = module.latest.image_ref
  tag        = each.key
}
