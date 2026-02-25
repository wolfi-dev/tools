terraform {
  required_providers {
    cosign = {
      source  = "chainguard-dev/cosign"
      version = "0.2.4"
    }
    apko = {
      source  = "chainguard-dev/apko"
      version = "1.0.9"
    }
    oci = {
      source  = "chainguard-dev/oci"
      version = "0.0.27"
    }
  }

  # We don't take advantage of terraform.tfstate, so we don't need to save state anywhere.
  #
  # The default "local" backend has pathological performance as state gets large, see:
  # https://github.com/opentofu/opentofu/issues/578
  #
  # Consider removing this if that's ever fixed and/or if we want to use tfstate.
  backend "inmem" {}
}

variable "target_repository" {
  type        = string
  description = "The root repo into which the images should be published (e.g., cgr.dev/chainguard). Individual images will be published within this root repo."
}

variable "archs" {
  type        = list(string)
  default     = []
  description = "The architectures to build for. If empty, defaults to x86_64 and aarch64."
}

provider "apko" {
  extra_repositories = ["https://packages.wolfi.dev/os"]
  extra_keyring      = ["https://packages.wolfi.dev/os/wolfi-signing.rsa.pub"]
  extra_packages     = ["wolfi-baselayout"]
  default_archs      = length(var.archs) == 0 ? ["x86_64", "aarch64"] : var.archs
}

provider "apko" {
  alias = "alpine"

  extra_repositories = ["https://dl-cdn.alpinelinux.org/alpine/edge/main"]
  extra_packages     = ["alpine-baselayout-data", "alpine-release", "ca-certificates-bundle"]
  // Don't build for riscv64, 386, arm/v6
  // Only build for: amd64, arm/v7, arm64, ppc64le, s390x
  default_archs = length(var.archs) == 0 ? ["amd64", "arm/v7", "arm64", "ppc64le", "s390x"] : var.archs
}

module "alpine-base" {
  source            = "./images/alpine-base"
  target_repository = "${var.target_repository}/alpine-base"
  providers         = { apko.alpine = apko.alpine }
}

module "apko" {
  source            = "./images/apko"
  target_repository = "${var.target_repository}/apko"
}

module "busybox" {
  source            = "./images/busybox"
  target_repository = "${var.target_repository}/busybox"
  providers         = { apko.alpine = apko.alpine }
}

module "gcc-musl" {
  source            = "./images/gcc-musl"
  target_repository = "${var.target_repository}/gcc-musl"
  providers         = { apko.alpine = apko.alpine }
}

module "git" {
  source            = "./images/git"
  target_repository = "${var.target_repository}/git"
  providers         = { apko.alpine = apko.alpine }
}

module "musl-dynamic" {
  source            = "./images/musl-dynamic"
  target_repository = "${var.target_repository}/musl-dynamic"
  providers         = { apko.alpine = apko.alpine }
}

module "sdk" {
  source            = "./images/sdk"
  target_repository = "${var.target_repository}/sdk"
}

module "static" {
  source            = "./images/static"
  target_repository = "${var.target_repository}/static"
  providers         = { apko.alpine = apko.alpine }
}

module "spdx-tools" {
  source            = "./images/spdx-tools"
  target_repository = "${var.target_repository}/spdx-tools"
}
