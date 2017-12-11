output "acpopsvpc_id" {
  value = "${aws_vpc.acpopsvpc.id}"
}

output "acpops_cidr_block" {
  value = "${var.acpops_cidr_block}"
}

output "acpcicdvpc_id" {
  value = "${aws_vpc.acpcicdvpc.id}"
}

output "acpcicd_cidr_block" {
  value = "${var.acpcicd_cidr_block}"
}

output "acpprodvpc_id" {
  value = "${aws_vpc.acpprodvpc.id}"
}

output "acpprod_cidr_block" {
  value = "${var.acpprod_cidr_block}"
}

output "acpvpnvpc_id" {
  value = "${aws_vpc.acpvpnvpc.id}"
}

output "acpvpn_cidr_block" {
  value = "${var.acpvpn_cidr_block}"
}
