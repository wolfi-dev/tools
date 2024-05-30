terraform {
  required_providers {
    oci = { source = "chainguard-dev/oci" }
    apko = {
      source                = "chainguard-dev/apko"
      configuration_aliases = [apko.alpine]
    }
  }
}

variable "target_repository" {
  description = "The docker repo into which the image and attestations should be published."
}

resource "oci_tag" "alpine" {
  depends_on = [module.test-alpine]
  digest_ref = module.alpine.image_ref
  tag        = "alpine"
}
