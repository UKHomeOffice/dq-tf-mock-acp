# pylint: disable=missing-docstring, line-too-long, protected-access
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
              name_prefix                   = "dq-"
            }
        """
        self.result = Runner(self.snippet).result

    def test_root_destroy(self):
        self.assertEqual(self.result["destroy"], False)

    def test_acpcicd_vpc_cidr_block(self):
        self.assertEqual(self.result['mock-acp']["aws_vpc.acpcicdvpc"]["cidr_block"], "10.7.0.0/16")

    def test_acpcicd_subnet_cidr_block(self):
        self.assertEqual(self.result['mock-acp']["aws_subnet.ACPCICDSubnet"]["cidr_block"], "10.7.1.0/24")

    def test_az(self):
        self.assertEqual(self.result['mock-acp']["aws_subnet.ACPCICDSubnet"]["availability_zone"], "eu-west-2a")

    def test_name_prefix_BastionHostLinuxACPCICD(self):
        self.assertEqual(self.result['mock-acp']["aws_instance.BastionHostLinuxACPCICD"]["tags.Name"], "dq-acpcicd-ec2-linux")

    def test_name_prefix_BastionsACPCICD(self):
        self.assertEqual(self.result['mock-acp']["aws_security_group.BastionsACPCICD"]["tags.Name"], "dq-acpcicd-sg")

    def test_name_prefix_acpcicdvpc(self):
        self.assertEqual(self.result['mock-acp']["aws_vpc.acpcicdvpc"]["tags.Name"], "dq-acpcicd-vpc")

#### ACPOPS

    def test_vpc_acpopscidr_block(self):
        self.assertEqual(self.result['mock-acp']["aws_vpc.acpopsvpc"]["cidr_block"], "10.6.0.0/16")

    def test_subnet_acpops_cidr_block(self):
        self.assertEqual(self.result['mock-acp']["aws_subnet.ACPOPSSubnet"]["cidr_block"], "10.6.1.0/24")

    def test_az(self):
        self.assertEqual(self.result['mock-acp']["aws_subnet.ACPOPSSubnet"]["availability_zone"], "eu-west-2a")

    def test_name_prefix_BastionHostLinuxACPOPS(self):
        self.assertEqual(self.result['mock-acp']["aws_instance.BastionHostLinuxACPOPS"]["tags.Name"], "dq-acpops-ec2-linux")

    def test_name_prefix_BastionsACPOPS(self):
        self.assertEqual(self.result['mock-acp']["aws_security_group.BastionsACPOPS"]["tags.Name"], "dq-acpops-sg")

    def test_name_prefix_acpopsvpc(self):
        self.assertEqual(self.result['mock-acp']["aws_vpc.acpopsvpc"]["tags.Name"], "dq-acpops-vpc")

# #### ACPPROD

    def test_vpc_acpprod_cidr_block(self):
        self.assertEqual(self.result['mock-acp']["aws_vpc.acpprodvpc"]["cidr_block"], "10.5.0.0/16")

    def test_subnet_acpprod_cidr_block(self):
        self.assertEqual(self.result['mock-acp']["aws_subnet.ACPPRODSubnet"]["cidr_block"], "10.5.1.0/24")

    def test_az(self):
        self.assertEqual(self.result['mock-acp']["aws_subnet.ACPPRODSubnet"]["availability_zone"], "eu-west-2a")

    def test_name_prefix_BastionHostLinuxACPPROD(self):
        self.assertEqual(self.result['mock-acp']["aws_instance.BastionHostLinuxACPPROD"]["tags.Name"], "dq-acpprod-ec2-linux")

    def test_name_prefix_BastionsACPPROD(self):
        self.assertEqual(self.result['mock-acp']["aws_security_group.BastionsACPPROD"]["tags.Name"], "dq-acpprod-sg")

    def test_name_prefix_acpprodvpc(self):
        self.assertEqual(self.result['mock-acp']["aws_vpc.acpprodvpc"]["tags.Name"], "dq-acpprod-vpc")

# #### ACPVPN

    def test_vpc_apcvpn_cidr_block(self):
        self.assertEqual(self.result['mock-acp']["aws_vpc.acpvpnvpc"]["cidr_block"], "10.4.0.0/16")

    def test_subnet_acpvpn_cidr_block(self):
        self.assertEqual(self.result['mock-acp']["aws_subnet.ACPVPNSubnet"]["cidr_block"], "10.4.1.0/24")

    def test_az(self):
        self.assertEqual(self.result['mock-acp']["aws_subnet.ACPVPNSubnet"]["availability_zone"], "eu-west-2a")

    def test_name_prefix_BastionHostLinuxACPVPN(self):
        self.assertEqual(self.result['mock-acp']["aws_instance.BastionHostLinuxACPVPN"]["tags.Name"], "dq-acpvpn-ec2-linux")

    def test_name_prefix_BastionsACPVPN(self):
        self.assertEqual(self.result['mock-acp']["aws_security_group.BastionsACPVPN"]["tags.Name"], "dq-acpvpn-sg")

    def test_name_prefix_acpvpnvpc(self):
        self.assertEqual(self.result['mock-acp']["aws_vpc.acpvpnvpc"]["tags.Name"], "dq-acpvpn-vpc")

if __name__ == '__main__':
    unittest.main()
