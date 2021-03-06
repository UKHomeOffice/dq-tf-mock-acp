# pylint: disable=missing-docstring, line-too-long, protected-access, E1101, C0202, E0602, W0109, R0904
import unittest
from runner import Runner


class TestE2E(unittest.TestCase):
    @classmethod
    def setUpClass(self):
        self.snippet = """

            provider "aws" {
              region = "eu-west-2"
              skip_credentials_validation = true
              skip_get_ec2_platforms = true
            }

            module "mock-acp" {
              source = "./mymodule"

              providers = {
                aws = "aws"
              }

              acpcicd_cidr_block            = "10.7.0.0/16"
              acpcicd_vpc_subnet_cidr_block = "10.7.1.0/24"
              acpops_cidr_block             = "10.6.0.0/16"
              acpops_vpc_subnet_cidr_block  = "10.6.1.0/24"
              acpprod_cidr_block            = "10.5.0.0/16"
              acpprod_vpc_subnet_cidr_block = "10.5.1.0/24"
              acpvpn_cidr_block             = "10.4.0.0/16"
              acpvpn_vpc_subnet_cidr_block  = "10.4.1.0/24"
              az                            = "eu-west-2a"
              naming_suffix                 = "preprod-dq"
              tester_ips                    = {
                ops_win_tester_ip = "1.1.1.1"
                ops_linux_tester_ip = "1.1.1.1"
                peering_tester_ip = "1.1.1.1"
                ext_tableau = "1.1.1.1"
                int_tableau = "1.1.1.1"
                gp_master = "1.1.1.1"
              }
             tester_ports                   = {
                ops_rdp_port = "3389"
                ops_ssh_port = "22"
                peering_http_port = "80"
                ext_tableau_port = "1025"
                int_tableau_port = "1026"
                gp_master_port = "1027"
             }
              route_table_cidr_blocks       = {
                ops_cidr = "1.2.3.0/24"
                apps_cidr = "1.2.3.0/24"
                peering_cidr = "1.2.3.0/24"
              }
              vpc_peering_connection_ids    = {
                peering_and_acpcicd = "1234"
                peering_and_acpprod = "1234"
                peering_and_acpops  = "1234"
                ops_and_acpvpn      = "1234"
              }
              acp_private_ips               = {
                cicd_tester_ip = "1.1.1.1"
                prod_tester_ip = "1.1.1.1"
                ops_tester_ip  = "1.1.1.1"
                vpn_tester_ip  = "1.1.1.1"
              }
            }
        """
        self.result = Runner(self.snippet).result

    def test_root_destroy(self):
        self.assertEqual(self.result["destroy"], False)

    def test_acpcicd_vpc_cidr_block(self):
        self.assertEqual(self.result['mock-acp']["aws_vpc.acpcicdvpc"]["cidr_block"], "10.7.0.0/16")

    def test_acpcicd_subnet_cidr_block(self):
        self.assertEqual(self.result['mock-acp']["aws_subnet.acpcicd_subnet"]["cidr_block"], "10.7.1.0/24")

    def test_az(self):
        self.assertEqual(self.result['mock-acp']["aws_subnet.acpcicd_subnet"]["availability_zone"], "eu-west-2a")

    def test_name_sg_cicd(self):
        self.assertEqual(self.result['mock-acp']["aws_security_group.acpcicd"]["tags.Name"], "sg-cicd-mock-acp-preprod-dq")

    def test_name_acpcicdvpc(self):
        self.assertEqual(self.result['mock-acp']["aws_vpc.acpcicdvpc"]["tags.Name"], "vpc-cicd-mock-acp-preprod-dq")

#### ACPOPS

    def test_vpc_acpopscidr_block(self):
        self.assertEqual(self.result['mock-acp']["aws_vpc.acpopsvpc"]["cidr_block"], "10.6.0.0/16")

    def test_subnet_acpops_cidr_block(self):
        self.assertEqual(self.result['mock-acp']["aws_subnet.acpops_subnet"]["cidr_block"], "10.6.1.0/24")

    def test_az_ops(self):
        self.assertEqual(self.result['mock-acp']["aws_subnet.acpops_subnet"]["availability_zone"], "eu-west-2a")

    def test_name_sg_sgops(self):
        self.assertEqual(self.result['mock-acp']["aws_security_group.acpops"]["tags.Name"], "sg-ops-mock-acp-preprod-dq")

    def test_name_acpopsvpc(self):
        self.assertEqual(self.result['mock-acp']["aws_vpc.acpopsvpc"]["tags.Name"], "vpc-ops-mock-acp-preprod-dq")

# #### ACPPROD

    def test_vpc_acpprod_cidr_block(self):
        self.assertEqual(self.result['mock-acp']["aws_vpc.acpprodvpc"]["cidr_block"], "10.5.0.0/16")

    def test_subnet_acpprod_cidr_block(self):
        self.assertEqual(self.result['mock-acp']["aws_subnet.acpprod_subnet"]["cidr_block"], "10.5.1.0/24")

    def test_az_prod(self):
        self.assertEqual(self.result['mock-acp']["aws_subnet.acpprod_subnet"]["availability_zone"], "eu-west-2a")

    def test_name_sg_prod(self):
        self.assertEqual(self.result['mock-acp']["aws_security_group.acpprod"]["tags.Name"], "sg-prod-mock-acp-preprod-dq")

    def test_name_prodvpc(self):
        self.assertEqual(self.result['mock-acp']["aws_vpc.acpprodvpc"]["tags.Name"], "vpc-prod-mock-acp-preprod-dq")

# #### ACPVPN

    def test_vpc_apcvpn_cidr_block(self):
        self.assertEqual(self.result['mock-acp']["aws_vpc.acpvpnvpc"]["cidr_block"], "10.4.0.0/16")

    def test_subnet_acpvpn_cidr_block(self):
        self.assertEqual(self.result['mock-acp']["aws_subnet.acpvpn_subnet"]["cidr_block"], "10.4.1.0/24")

    def test_az_vpn(self):
        self.assertEqual(self.result['mock-acp']["aws_subnet.acpvpn_subnet"]["availability_zone"], "eu-west-2a")

    def test_name_suffix_sg_vpn(self):
        self.assertEqual(self.result['mock-acp']["aws_security_group.acpvpn"]["tags.Name"], "sg-vpn-mock-acp-preprod-dq")

    def test_name_suffix_vpnvpc(self):
        self.assertEqual(self.result['mock-acp']["aws_vpc.acpvpnvpc"]["tags.Name"], "vpc-vpn-mock-acp-preprod-dq")

if __name__ == '__main__':
    unittest.main()
