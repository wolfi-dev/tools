variable "extra_packages" {
  description = "Extra packages to install."
  type        = list(string)
  default     = []
}

variable "extra_repositories" {
  description = "Extra repositories to add."
  type        = list(string)
  default     = []
}

variable "root" {
  description = "Whether to run as root."
  type        = bool
  default     = false
}

output "config" {
  value = jsonencode({
    contents = {
      repositories = var.extra_repositories
      packages = concat([
        "git",
        "git-lfs",
        "openssh-client",
      ], var.extra_packages)
    }
    accounts = {
      groups = [{
        groupname = "git"
        gid       = 65532
      }]
      users = [{
        username = "git"
        uid      = 65532
        gid      = 65532
      }]
      run-as = var.root ? 0 : 65532
    }
    entrypoint = {
      command = "/usr/bin/git"
    }
    work-dir = "/home/git"
  })
}
