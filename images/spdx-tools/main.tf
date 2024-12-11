terraform {
  required_providers {
    apko = { source = "chainguard-dev/apko" }
    oci  = { source = "chainguard-dev/oci" }
  }
}

variable "target_repository" {
  description = "The docker repo into which the image and attestations should be published."
}

module "latest" {
  source  = "chainguard-dev/apko/publisher"
  version = "0.0.17"

  target_repository = var.target_repository
  config            = file("${path.module}/configs/latest.apko.yaml")
  check_sbom        = true
}

resource "oci_tag" "version-tags" {
  digest_ref = module.latest.image_ref
  tag        = "latest"
}
