provider "aws" {
  region = "eu-west-1"
}

locals {
  name        = "app"
  environment = "test"
}

##-----------------------------------------------------------------------------
## VPC Module Call.
##-----------------------------------------------------------------------------
module "vpc" {
  source      = "git::git@github.com:opz0/terraform-aws-vpc.git?ref=master"
  name        = "app"
  environment = "test"
  cidr_block  = "10.0.0.0/16"
}

##-----------------------------------------------------------------------------
## Security Group Rules Module Call.
##-----------------------------------------------------------------------------
module "security_group_rules" {
  source         = "./../../."
  name           = local.name
  environment    = local.environment
  vpc_id         = module.vpc.vpc_id
  new_sg         = false
  existing_sg_id = "sg-0c6f081b520533c20"

  ## INGRESS Rules
  existing_sg_ingress_rules_with_cidr_blocks = [{
    rule_count  = 1
    allow_port  = 22
    protocol    = "tcp"
    cidr_blocks = ["10.9.0.0/16"]
    description = "Allow ssh traffic."
    },
    {
      rule_count  = 2
      allow_port  = 27017
      protocol    = "tcp"
      cidr_blocks = ["10.9.0.0/16"]
      description = "Allow Mongodb traffic."
    }
  ]

  ## EGRESS Rules
  existing_sg_egress_rules_with_cidr_blocks = [{
    rule_count  = 1
    allow_port  = 22
    protocol    = "tcp"
    cidr_blocks = ["10.9.0.0/16"]
    description = "Allow ssh outbound traffic."
    },
    {
      rule_count  = 2
      allow_port  = 27017
      protocol    = "tcp"
      cidr_blocks = ["10.9.0.0/16"]
      description = "Allow Mongodb outbound traffic."
  }]

}