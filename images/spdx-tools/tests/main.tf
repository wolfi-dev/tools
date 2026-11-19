terraform {
  required_providers {
    oci = { source = "chainguard-dev/oci" }
  }
}

variable "digest" {
  description = "The image digest to run tests over."
}

data "oci_exec_test" "version" {
  digest = var.digest
  script = "docker run --rm $IMAGE_NAME Version | grep '^SPDX Tool Version: '"
}

data "oci_exec_test" "verify-and-convert" {
  digest = var.digest
  script = "${path.module}/01-verify-and-convert.sh"
}
