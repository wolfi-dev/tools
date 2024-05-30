terraform {
  required_providers {
    oci = { source = "chainguard-dev/oci" }
    apko = {
      source                = "chainguard-dev/apko"
      configuration_aliases = [apko.alpine]
    }
  }
}

locals {
  accounts = toset(["nonroot", "root"])
}

variable "target_repository" {
  description = "The docker repo into which the image and attestations should be published."
}

resource "oci_tag" "alpine" {
  depends_on = [module.test-latest-alpine]
  digest_ref = module.latest-alpine["nonroot"].image_ref
  tag        = "alpine"
}

resource "oci_tag" "alpine-root" {
  depends_on = [module.test-latest-alpine]
  digest_ref = module.latest-alpine["root"].image_ref
  tag        = "alpine-root"
}
