# Terraform Azure VNET Module

This repository contains a reusable Terraform module for provisioning an Azure Virtual Network (VNET) along with related networking resources. The module is designed to be flexible and secure, allowing for customization based on different environments and requirements.

## Table of Contents

- [Module Overview](#module-overview)
- [Usage](#usage)
- [Input Variables](#input-variables)
- [Outputs](#outputs)
- [Examples](#examples)
- [Automation](#automation)
- [Contributing](#contributing)

## Module Overview

The Azure VNET module provisions a Virtual Network and associated resources such as subnets and Network Security Groups (NSGs). It is designed to be reusable across different setups, making it suitable for both development and production environments.

## Usage

To use this module, include it in your Terraform configuration as follows:

```hcl
module "vnet" {
  source              = "../modules/vnet"
  vnet_name           = var.vnet_name
  address_space       = var.address_space
  subnet_configs      = var.subnet_configs
  enable_nsg         = var.enable_nsg
}
```

## Input Variables

The following input variables are available for customization:

- `vnet_name`: The name of the Virtual Network.
- `address_space`: The address space for the VNET (e.g., `10.0.0.0/16`).
- `subnet_configs`: A list of subnet configurations.
- `enable_nsg`: A boolean to enable or disable Network Security Groups.

Refer to the `variables.tf` file in the module for more details.

## Outputs

The module provides the following outputs:

- `vnet_id`: The ID of the created Virtual Network.
- `subnet_ids`: A list of IDs for the created subnets.

Refer to the `outputs.tf` file in the module for more details.

## Examples

For examples of how to use this module in different environments, please refer to the `environments` directory.

## Automation

Documentation can be automated using tools like [Terraform-docs](https://github.com/terraform-docs/terraform-docs). To generate documentation, run the following command in the module directory:

```bash
terraform-docs markdown . > README.md
```

## Contributing

Contributions are welcome! Please submit a pull request or open an issue for any enhancements or bug fixes. Ensure that your code adheres to the project's coding standards and includes appropriate tests.

---

This README provides a comprehensive overview of the Azure VNET module, ensuring users have the necessary information to utilize it effectively.