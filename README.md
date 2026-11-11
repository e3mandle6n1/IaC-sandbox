# IaC-sandbox

[![Azure](https://img.shields.io/badge/Azure-0078D4?logo=microsoftazure&logoColor=fff)](#)
[![Bicep](https://img.shields.io/badge/Bicep-IaC-122A4C?logo=azureartifacts&logoColor=fff)](#)
[![Terraform](https://img.shields.io/badge/Terraform-7B42BC?logo=terraform&logoColor=fff)](#)
[![HCL](https://img.shields.io/badge/HCL-844FBA?logo=hashicorp&logoColor=fff)](#)
[![Azure CLI](https://img.shields.io/badge/Azure%20CLI-az-0078D4?logo=microsoftazure&logoColor=fff)](#)
[![AZ-104](https://img.shields.io/badge/AZ--104-Labs-0078D4)](#)

Practice Azure AZ-104 labs as infrastructure as code. Portal exercises get a
Bicep and/or Terraform version so you can redeploy the same layout without
clicking through the UI again.

## What this repo contains

| Path | What it is |
|---|---|
| `AZ104/Lab04/GPs/bicep/` | Guided project: hub-and-spoke VNets, subnets, peering |
| `AZ104/Lab04/GPs/terraform/` | Same Lab04 guided project in Terraform |
| `AZ104/Lab07/bicep/` | Lab07 storage / network / backup modules |

Local values stay out of git (`main.parameters.json`, `terraform.tfvars`). Copy the
committed `*.example` files and fill them in.

## Prerequisites

- An Azure subscription and [Azure CLI](https://learn.microsoft.com/cli/azure/install-azure-cli)
- [Bicep](https://learn.microsoft.com/azure/azure-resource-manager/bicep/install) (comes with recent Azure CLI)
- [Terraform](https://developer.hashicorp.com/terraform/install) for the Terraform labs

## Quick start

```bash
git clone https://github.com/e3mandle6n1/IaC-sandbox.git
cd IaC-sandbox
az login
az account set --subscription "<name-or-id>"
```

**Bicep (Lab04 guided project):**

```bash
cp AZ104/Lab04/GPs/bicep/main.parameters.example.json AZ104/Lab04/GPs/bicep/main.parameters.json
# edit location / resourceGroupName if needed

az deployment sub create \
  --location southafricanorth \
  --template-file AZ104/Lab04/GPs/bicep/main.bicep \
  --parameters @AZ104/Lab04/GPs/bicep/main.parameters.json
```

**Terraform (same lab):**

```bash
cd AZ104/Lab04/GPs/terraform
cp terraform.tfvars.example terraform.tfvars
terraform init
terraform plan
terraform apply
```

`--location` on `az deployment sub create` is where the *deployment record*
lives. Resource region still comes from the parameters / tfvars file.

## Notes

- Do not commit real subscription IDs, secrets, or filled-in parameter files.
- `main` is protected: changes go in through pull requests.
