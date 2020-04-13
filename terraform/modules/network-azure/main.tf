terraform {
  required_version = ">= 0.12"
}

module "images" {
  source = "../images-azure"

  os = "${var.os}"
}
