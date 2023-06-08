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
  extra_repositories = ["https://packages.wolfi.dev/os", "${path.module}/../../packages"]
  extra_keyring      = ["https://packages.wolfi.dev/os/wolfi-signing.rsa.pub", "${path.module}/../../melange.rsa.pub"]
  default_archs      = ["arm64", "amd64"]
}

module "latest" {
  source            = "../../tflib/publisher"
  target_repository = var.target_repository
  config            = file("${path.module}/configs/latest.apko.yaml")
  extra_packages    = ["wolfi-baselayout"]
}

module "test-latest" {
  source = "./tests"
  digest = module.latest.image_ref
}

resource "oci_tag" "version-tags" {
  depends_on = [ module.test-latest ]
  for_each   = toset(["latest"])
  digest_ref = module.latest.image_ref
  tag        = each.key
}
