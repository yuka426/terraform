terraform {
  cloud {
    organization = "dessun"
    hostname     = "app.terraform.io"

    workspaces {
      name = "emptio_stg"
    }
  }
}
