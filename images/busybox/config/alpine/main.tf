variable "extra_packages" {
  description = "Extra packages to install."
  type        = list(string)
  default     = []
}

output "config" {
  value = jsonencode({
    contents = {
      packages = concat([
        "busybox",
        "ssl_client", # ssl_client allows the busybox wget applet to use https.
      ], var.extra_packages)
    }
    accounts = {
      groups = [{
        groupname = "nonroot"
        gid       = 65532
      }]
      users = [{
        username = "nonroot"
        uid      = 65532
        gid      = 65532
      }]
      run-as = 65532
    }
  })
}
