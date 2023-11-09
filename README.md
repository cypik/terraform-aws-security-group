# Terraform-aws-security-group

# AWS Infrastructure Provisioning with Terraform

## Table of Contents
- [Introduction](#introduction)
- [Usage](#usage)
- [Module Inputs](#module-inputs)
- [Module Outputs](#module-outputs)
- [License](#license)

## Introduction
This module is designed to create an AWS Virtual Private Cloud (VPC) and associated security groups using Terraform. It allows you to easily define and provision a VPC and its associated security groups with specific ingress and egress rules.

## Usage
To use this module, you can include it in your Terraform configuration. Here's an example of how to use it:

## Examples

## Example: Basic

```hcl
module "security_group" {
  source      = "git::https://github.com/opz0/terraform-aws-security-group.git?ref=v1.0.0"
  name        = local.name
  environment = local.environment
  vpc_id      = module.vpc.vpc_id

  ## INGRESS Rules
  new_sg_ingress_rules_with_cidr_blocks = [
    {
      rule_count  = 1
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["172.16.0.0/16"]
      description = "Allow ssh traffic."
    },
    {
      rule_count  = 2
      from_port   = 27017
      to_port     = 27017
      protocol    = "tcp"
      cidr_blocks = ["172.16.0.0/16"]
      description = "Allow MongoDB traffic."
    }
  ]

  ## EGRESS Rules
  new_sg_egress_rules_with_cidr_blocks = [
    {
      rule_count  = 1
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["172.16.0.0/16"]
      description = "Allow ssh outbound traffic."
    },
    {
      rule_count  = 2
      from_port   = 27017
      to_port     = 27017
      protocol    = "tcp"
      cidr_blocks = ["172.16.0.0/16"]
      description = "Allow MongoDB outbound traffic."
    }
  ]
}
```

## Example: Complete
```hcl
module "security_group" {
  source      = "git::https://github.com/opz0/terraform-aws-security-group.git?ref=v1.0.0"
  name        = local.name
  environment = local.environment
  vpc_id      = module.vpc.vpc_id

  ## INGRESS Rules
  new_sg_ingress_rules_with_cidr_blocks = [{
    rule_count  = 1
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["172.16.0.0/16"]
    description = "Allow ssh traffic."
    },
    {
      rule_count  = 2
      from_port   = 27017
      to_port     = 27017
      protocol    = "tcp"
      cidr_blocks = ["172.16.0.0/16"]
      description = "Allow Mongodb traffic."
    }
  ]

  new_sg_ingress_rules_with_self = [{
    rule_count  = 1
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    description = "Allow ssh traffic."
    },
    {
      rule_count  = 2
      from_port   = 27017
      to_port     = 22
      protocol    = "tcp"
      description = "Allow Mongodb traffic."
    }
  ]

  new_sg_ingress_rules_with_source_sg_id = [{
    rule_count               = 1
    from_port                = 22
    to_port                  = 22
    protocol                 = "tcp"
    source_security_group_id = "sg-03de2036c5096cb34"
    description              = "Allow ssh traffic."
    },
    {
      rule_count               = 2
      from_port                = 27017
      to_port                  = 27017
      protocol                 = "tcp"
      source_security_group_id = "sg-03de2036c5096cb34"
      description              = "Allow Mongodb traffic."
  }]

  ## EGRESS Rules
  new_sg_egress_rules_with_cidr_blocks = [{
    rule_count  = 1
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [module.vpc.vpc_cidr_block, "172.16.0.0/16"]
    description = "Allow ssh outbound traffic."
    },
    {
      rule_count  = 2
      from_port   = 27017
      to_port     = 27017
      protocol    = "tcp"
      cidr_blocks = ["172.16.0.0/16"]
      description = "Allow Mongodb outbound traffic."
    }
  ]

  new_sg_egress_rules_with_self = [{
    rule_count  = 1
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    description = "Allow ssh outbound traffic."
    },
    {
      rule_count  = 2
      from_port   = 27017
      to_port     = 27017
      protocol    = "tcp"
      description = "Allow Mongodb traffic."
  }]

  new_sg_egress_rules_with_source_sg_id = [{
    rule_count               = 1
    from_port                = 22
    to_port                  = 22
    protocol                 = "tcp"
    source_security_group_id = "sg-03de2036c5096cb34"
    description              = "Allow ssh outbound traffic."
    },
    {
      rule_count               = 2
      from_port                = 27017
      to_port                  = 27017
      protocol                 = "tcp"
      source_security_group_id = "sg-03de2036c5096cb34"
      description              = "Allow Mongodb traffic."
  }]
}
```

## Example: Only_rules

```hcl
module "security_group_rules" {
  source         = "git::https://github.com/opz0/terraform-aws-security-group.git?ref=v1.0.0"
  name           = local.name
  environment    = local.environment
  vpc_id         = module.vpc.vpc_id
  new_sg         = false
  existing_sg_id = "sg-0c6f081b520533c20"

  ## INGRESS Rules
  existing_sg_ingress_rules_with_cidr_blocks = [{
    rule_count  = 1
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.9.0.0/16"]
    description = "Allow ssh traffic."
    },
    {
      rule_count  = 2
      from_port   = 27017
      to_port     = 27017
      protocol    = "tcp"
      cidr_blocks = ["10.9.0.0/16"]
      description = "Allow Mongodb traffic."
    }
  ]

  ## EGRESS Rules
  existing_sg_egress_rules_with_cidr_blocks = [{
    rule_count  = 1
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.9.0.0/16"]
    description = "Allow ssh outbound traffic."
    },
    {
      rule_count  = 2
      from_port   = 27017
      to_port     = 27017
      protocol    = "tcp"
      cidr_blocks = ["10.9.0.0/16"]
      description = "Allow Mongodb outbound traffic."
  }]
}
```

## Example: Prefix_list

```hcl
module "security_group" {
  source              = "git::https://github.com/opz0/terraform-aws-security-group.git?ref=v1.0.0"
  name                = local.name
  environment         = local.environment
  vpc_id              = module.vpc.vpc_id
  prefix_list_enabled = true
  entry = [{
    cidr = "10.19.0.0/16"
  }]

  ## INGRESS Rules
  new_sg_ingress_rules_with_prefix_list = [{
    rule_count  = 1
    allow_port  = 22
    to_port     = 22
    protocol    = "tcp"
    description = "Allow ssh traffic."
  }]

  ## EGRESS Rules
  new_sg_egress_rules_with_prefix_list = [{
    rule_count  = 1
    allow_port  = 3306
    protocol    = "tcp"
    description = "Allow mysql/aurora outbound traffic."
  }]
}
```

## Module Inputs
- `name`: A name for your application.
- `environment`: The environment for your application.
- `cidr_block`: The IP range for your VPC.
- `vpc_id`: The ID of the VPC created by the VPC module.
For security group settings, you can configure the ingress and egress rules using variables like:
- `new_sg_ingress_rules_with_cidr_blocks`.
- `new_sg_ingress_rules_with_self`.
- `new_sg_ingress_rules_with_source_sg_id`.
- `new_sg_egress_rules_with_cidr_blocks`.
- `new_sg_egress_rules_with_self`.
- `new_sg_egress_rules_with_source_sg_id`.
You can define the rules for SSH and MongoDB traffic as shown in the example.
## Module Outputs
- `vpc_id` (string): The ID of the VPC created.
- `security_group_id`: The ID of the created security group.
- Other relevant security group outputs (modify as needed).

## Examples
For detailed examples on how to use this module, please refer to the 'examples' directory within this repository.

## Author
Your Name Replace '[License Name]' and '[Your Name]' with the appropriate license and your information. Feel free to expand this README with additional details or usage instructions as needed for your specific use case.

## License
This project is licensed under the MIT License - see the [LICENSE](https://github.com/opz0/terraform-aws-security-group/blob/master/LICENSE) file for details.
