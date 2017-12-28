# DQ Terraform MOCK ACP module

[![Build Status](https://drone.digital.homeoffice.gov.uk/api/badges/UKHomeOffice/dq-tf-mock-acp/status.svg)](https://drone.digital.homeoffice.gov.uk/UKHomeOffice/dq-tf-mock-acp)

This module describes required VPC components for deploying our modules into the DQ AWS environments.

It can be run against both Production and non-Production environments by setting a variable at runtime to switch the provider used.

## Content overview

This repo controls the deployment of our application modules.

It consists of the following core elements:

### main.tf

Describe the provider used.

### acpcicd.tf

This file has the basic VPC components:
- VPC
- Route table
- Elastic IP
- NAT gateway
- Private subnet and route table association

### acpops.tf

This file has the basic VPC components:
- VPC
- Route table
- Elastic IP
- NAT gateway
- Private subnet and route table association

### acpprod.tf

This file has the basic VPC components:
- VPC
- Route table
- Elastic IP
- NAT gateway
- Private subnet and route table association

### acpvpn.tf

This file has the basic VPC components:
- VPC
- Route table
- Elastic IP
- NAT gateway
- Private subnet and route table association

### instances.tf

This set of resources describe the following:
- Module for each EC2 instance launched into their respective VPCs
- Security group for each EC2 instance

### output.tf

Various data outputs for other modules/consumers.

### variable.tf

Input data for resources within this repo.

### tests/mock_acp_test.py

Code and resource tester with mock data. It can be expanded by adding further definitions to the unit.

## User guide

### Prepare your local environment

This project currently depends on:

* drone v0.5+dev
* terraform v0.11.1+
* terragrunt v0.13.21+
* python v3.6.3+

Please ensure that you have the correct versions installed (it is not currently tested against the latest version of Drone)

### How to run/deploy

To run the scripts from your local machine:

```
# export/set variables
terragrunt plan
terragrunt apply
```

## FAQs

### The remote state isn't updating, what do I do?

If the CI process appears to be stuck with a stale `tf state` then run the following command to force a refresh:

```
terragrunt refresh
```
