terraform {
  cloud {
    organization = "miyata"
    hostname     = "app.terraform.io"

    workspaces {
      name = "miyata1"
    }
  }
}
