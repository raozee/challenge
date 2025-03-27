# VNET Module for Terraform on Azure

This README provides documentation for the Azure VNET Terraform module. This module allows you to provision a Virtual Network (VNET) and related networking resources in Azure, designed with flexibility and security in mind.

## Usage

To use this module, include it in your Terraform configuration as follows:

```hcl
module "vnet" {
  source              = "../modules/vnet"
  vnet_name           = var.vnet_name
  address_space       = var.address_space
  subnet_configs      = var.subnet_configs
  enable_nsg         = var.enable_nsg
  nsg_rules           = var.nsg_rules
}
```

## Input Variables

| Variable Name       | Description                                           | Type           | Default Value |
|---------------------|-------------------------------------------------------|----------------|---------------|
| `vnet_name`         | The name of the VNET.                                | `string`       | `""`          |
| `address_space`     | The address space for the VNET (CIDR notation).     | `list(string)` | `[]`          |
| `subnet_configs`    | List of subnet configurations.                        | `list(object)` | `[]`          |
| `enable_nsg`        | Flag to enable Network Security Group.                | `bool`         | `false`       |
| `nsg_rules`         | List of NSG rules if NSG is enabled.                 | `list(object)` | `[]`          |

### Subnet Configuration Object

The `subnet_configs` variable should be a list of objects with the following attributes:

| Attribute Name      | Description                                           | Type           |
|---------------------|-------------------------------------------------------|----------------|
| `name`              | The name of the subnet.                              | `string`       |
| `address_prefix`    | The address prefix for the subnet (CIDR notation).  | `string`       |

### NSG Rule Object

If `enable_nsg` is set to true, the `nsg_rules` variable should be a list of objects with the following attributes:

| Attribute Name      | Description                                           | Type           |
|---------------------|-------------------------------------------------------|----------------|
| `name`              | The name of the NSG rule.                            | `string`       |
| `priority`          | The priority of the NSG rule.                        | `number`       |
| `direction`         | The direction of the rule (Inbound/Outbound).       | `string`       |
| `access`            | Allow or Deny access.                                | `string`       |
| `protocol`          | The protocol (TCP/UDP/All).                          | `string`       |
| `source_address`    | The source address or CIDR.                          | `string`       |
| `destination_address`| The destination address or CIDR.                    | `string`       |
| `source_port`       | The source port or range.                            | `string`       |
| `destination_port`  | The destination port or range.                       | `string`       |

## Outputs

This module provides the following outputs:

| Output Name         | Description                                           |
|---------------------|-------------------------------------------------------|
| `vnet_id`           | The ID of the created VNET.                          |
| `subnet_ids`        | List of IDs of the created subnets.                  |
| `nsg_id`            | The ID of the created Network Security Group (if enabled). |

## Automation of Documentation

To automate the generation of this documentation, you can use tools like [Terraform-docs](https://github.com/terraform-docs/terraform-docs). This tool can automatically generate markdown documentation from your Terraform files, ensuring that your README is always up to date with the latest variable and output definitions.

## Example

Here is an example of how to call this module in your Terraform configuration:

```hcl
module "example_vnet" {
  source              = "../modules/vnet"
  vnet_name           = "example-vnet"
  address_space       = ["10.0.0.0/16"]
  subnet_configs      = [
    {
      name           = "subnet1"
      address_prefix = "10.0.1.0/24"
    },
    {
      name           = "subnet2"
      address_prefix = "10.0.2.0/24"
    }
  ]
  enable_nsg         = true
  nsg_rules           = [
    {
      name               = "AllowHTTP"
      priority           = 100
      direction          = "Inbound"
      access             = "Allow"
      protocol           = "Tcp"
      source_address     = "*"
      destination_address= "*"
      source_port        = "*"
      destination_port   = "80"
    }
  ]
}
```

This example demonstrates how to configure a VNET with two subnets and a Network Security Group that allows HTTP traffic. Adjust the parameters as needed for your specific use case.