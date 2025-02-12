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
  config = jsonencode({
    contents = {
      packages = ["apko"]
    }
    entrypoint = {
      command = "/usr/bin/apko"
    }
  })
  check_sbom = true
}

data "oci_exec_test" "version" {
  digest = module.latest.image_ref
  script = "docker run --rm $${IMAGE_NAME} version"
}

resource "oci_tag" "latest" {
  depends_on = [data.oci_exec_test.version]
  digest_ref = module.latest.image_ref
  tag        = "latest"
}
