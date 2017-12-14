variable "acpcicd_cidr_block" {}
variable "acpcicd_vpc_subnet_cidr_block" {}
variable "acpops_cidr_block" {}
variable "acpops_vpc_subnet_cidr_block" {}
variable "acpprod_cidr_block" {}
variable "acpprod_vpc_subnet_cidr_block" {}
variable "acpvpn_cidr_block" {}
variable "acpvpn_vpc_subnet_cidr_block" {}
variable "az" {}
variable "name_prefix" {}

variable "route_table_cidr_blocks" {
  type = "map"
}

variable "vpc_peering_connection_ids" {
  type = "map"
}
