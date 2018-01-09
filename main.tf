provider "aws" {}

locals {
  naming_suffix = "mock-acp-${var.naming_suffix}"
}
