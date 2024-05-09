terraform {
  required_providers {
    cosign = {
      source  = "chainguard-dev/cosign"
      version = "0.0.20"
    }
    apko = {
      source  = "chainguard-dev/apko"
      version = "0.15.5"
    }
  }
}

variable "target_repository" {}

variable "config" {}

variable "extra_packages" {
  type    = list(string)
  default = ["wolfi-baselayout"]
}

variable "check_sbom" {
  type        = bool
  default     = false
  description = "Whether to run the NTIA conformance checker over the images we produce prior to attesting the SBOMs."
}

module "this" {
  source  = "chainguard-dev/apko/publisher"
  version = "0.0.12"

  target_repository = var.target_repository
  config            = var.config
  extra_packages    = var.extra_packages
  check_sbom        = var.check_sbom
}

output "image_ref" {
  value = module.this.image_ref
}

output "config" {
  value = module.this.config
}
