variable "acpcicd_cidr_block" {}
variable "acpcicd_vpc_subnet_cidr_block" {}
variable "acpops_cidr_block" {}
variable "acpops_vpc_subnet_cidr_block" {}
variable "acpprod_cidr_block" {}
variable "acpprod_vpc_subnet_cidr_block" {}
variable "acpvpn_cidr_block" {}
variable "acpvpn_vpc_subnet_cidr_block" {}
variable "az" {}

variable "naming_suffix" {
  default     = false
  description = "Naming suffix for tags, value passed from dq-tf-apps"
}

variable "tester_ips" {
  description = "Mock EC2 device to test against in Ops and Peering VPC"
  type        = "map"
}

variable "tester_ports" {
  description = "Mock EC2 devices open ports in Ops and Peering VPC"
  type        = "map"
}

variable "route_table_cidr_blocks" {
  type = "map"
}

variable "vpc_peering_connection_ids" {
  type = "map"
}

variable "acp_private_ips" {
  type = "map"
}
