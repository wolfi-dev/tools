terraform {
  required_providers {
    apko = { source = "chainguard-dev/apko" }
    oci  = { source = "chainguard-dev/oci" }
  }
}

variable "target_repository" {
  description = "The docker repo into which the image and attestations should be published."
}

provider "apko" {
  extra_repositories = ["https://dl-cdn.alpinelinux.org/alpine/edge/main"]
  default_archs      = ["386", "amd64", "arm64", "arm/v6", "arm/v7", "ppc64le", "riscv64", "s390x"]
}

module "latest" {
  source            = "../../tflib/publisher"
  target_repository = var.target_repository
  config            = file("${path.module}/configs/latest.apko.yaml")
  extra_packages    = [] # The default pulls in wolfi-baselayout which cannot be used in alpine
}

module "test-latest" {
  source = "./tests"
  digest = module.latest.image_ref
}

resource "oci_tag" "version-tags" {
  depends_on = [ module.test-latest ]
  digest_ref = module.latest.image_ref
  tag        = "latest"
}
