# IaC-sandbox

[![Azure](https://img.shields.io/badge/Azure-0078D4?logo=microsoftazure&logoColor=fff)](#)
[![Bicep](https://img.shields.io/badge/Bicep-IaC-122A4C?logo=azureartifacts&logoColor=fff)](#)
[![Terraform](https://img.shields.io/badge/Terraform-7B42BC?logo=terraform&logoColor=fff)](#)
[![HCL](https://img.shields.io/badge/HCL-844FBA?logo=hashicorp&logoColor=fff)](#)
[![Azure CLI](https://img.shields.io/badge/Azure%20CLI-az-0078D4?logo=microsoftazure&logoColor=fff)](#)
[![AZ-104](https://img.shields.io/badge/AZ--104-Labs-0078D4)](#)

Practice Azure AZ-104 labs as infrastructure as code. Portal exercises get a
Bicep and/or Terraform version to allow easy redeployment without
clicking through the UI again.

## Layout

```text
AZ104/
  LabXX/
    bicep/        # Bicep templates (+ *.parameters.example.json)
    terraform/    # Terraform configs (+ terraform.tfvars.example)
    GPs/          # Guided projects (same bicep/ / terraform/ split)
```

Each lab folder is self-contained. Open it, copy the example params, deploy.

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

**Bicep** (from a lab’s `bicep/` folder):

```bash
cp main.parameters.example.json main.parameters.json
# edit values as needed

az deployment sub create \
  --location <deployment-record-region> \
  --template-file main.bicep \
  --parameters @main.parameters.json
```

Some labs deploy at resource-group scope instead, check that lab’s `main.bicep`
`targetScope` and use `az deployment group create` when it says so.

**Terraform** (from a lab’s `terraform/` folder):

```bash
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
