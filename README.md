# Multi-Cloud DevSecOps Infrastructure Automation Platform

A hands-on multi-cloud infrastructure engineering project designed to automate secure AWS and Microsoft Azure infrastructure using Terraform, GitHub Actions, Infrastructure as Code (IaC), and DevSecOps practices.

## Project Objectives

This project demonstrates practical Cloud and Infrastructure Engineering capabilities across:

- Amazon Web Services (AWS)
- Microsoft Azure
- Terraform Infrastructure as Code
- Multi-cloud networking
- Identity and access management
- Git-based infrastructure change management
- CI/CD with GitHub Actions
- Infrastructure security scanning
- Automated validation and deployment
- Monitoring and operational visibility

## Current Architecture

### AWS Environment

**Region:** `eu-central-1` (Frankfurt)

**VPC:** `10.20.0.0/16`

| Network Tier | CIDR | Purpose |
| --- | --- | --- |
| Public | `10.20.1.0/24` | Internet-facing resources |
| Private Application | `10.20.10.0/24` | Private application workloads |
| Management | `10.20.20.0/24` | Infrastructure management resources |

The public subnet uses a dedicated route table with a default IPv4 route (`0.0.0.0/0`) through an AWS Internet Gateway.

The private application and management subnets remain isolated from direct Internet Gateway routing.

### AWS Network Design

```text
                         Internet
                            |
                            v
                    Internet Gateway
                            |
                            v
                   Public Route Table
                     0.0.0.0/0 -> IGW
                            |
                            v
AWS VPC: 10.20.0.0/16
|
+-- Public Subnet
|   10.20.1.0/24
|   Public IPv4 assignment enabled
|
+-- Private Application Subnet
|   10.20.10.0/24
|   No direct Internet Gateway route
|
+-- Management Subnet
    10.20.20.0/24
    No direct Internet Gateway route
```

## AWS Infrastructure Implemented

The current AWS environment includes:

- VPC with DNS support and DNS hostnames
- Public subnet
- Private application subnet
- Management subnet
- Internet Gateway
- Dedicated public route table
- Default Internet route
- Public subnet route table association
- Standardized Terraform resource tagging
- Terraform outputs for infrastructure IDs
- IAM Identity Center authentication for local administration

All deployed AWS infrastructure is managed through Terraform rather than manual resource creation.

## Infrastructure as Code Workflow

The current infrastructure workflow follows:

```text
Terraform Code
      |
      v
terraform fmt
      |
      v
terraform validate
      |
      v
terraform plan
      |
      v
Manual Review
      |
      v
terraform apply
      |
      v
AWS Infrastructure
      |
      v
AWS CLI Verification
```

This workflow ensures infrastructure changes are formatted, validated, reviewed, deployed, and independently verified.

## Identity and Access Management

Local AWS administration uses AWS IAM Identity Center.

```text
AWS IAM Identity Center
          |
          v
   Federated User
          |
          v
AdministratorAccess Permission Set
          |
          v
Temporary Assumed-Role Credentials
          |
          v
     AWS CLI / Terraform
```

This avoids storing long-lived AWS access keys in the project repository.

## Security Practices

The project currently implements:

- AWS IAM Identity Center authentication
- Temporary assumed-role credentials
- No long-lived AWS access keys in source control
- Terraform state excluded from Git
- Sensitive `.tfvars` files excluded from Git
- Private subnet isolation
- Controlled public routing through an Internet Gateway
- Infrastructure tagging for governance and ownership
- Terraform plan review before deployment
- Independent AWS API verification after deployment

Future phases will introduce automated security scanning, policy checks, GitHub OIDC authentication, and CI/CD deployment controls.

## Terraform Outputs

The AWS configuration currently exposes:

- AWS region
- VPC ID
- Public subnet ID
- Private application subnet ID
- Management subnet ID

These outputs allow infrastructure information to be consumed by future modules and automation without hard-coding generated AWS resource IDs.

## Repository Structure

```text
multi-cloud-devsecops-platform/
|
+-- .github/
|   +-- workflows/
|
+-- docs/
|
+-- modules/
|   +-- aws/
|   +-- azure/
|
+-- scripts/
|
+-- terraform/
|   +-- aws/
|   |   +-- main.tf
|   |   +-- outputs.tf
|   |   +-- providers.tf
|   |   +-- variables.tf
|   |   +-- versions.tf
|   |   +-- .terraform.lock.hcl
|   |
|   +-- azure/
|
+-- .gitignore
+-- README.md
```

Local Terraform state and provider working directories are intentionally excluded from source control.

## Technology Stack

- Terraform
- Amazon Web Services (AWS)
- Microsoft Azure
- Git
- GitHub
- GitHub Actions
- AWS IAM Identity Center
- AWS CLI
- Azure CLI
- Visual Studio Code
- DevSecOps tooling

## Project Roadmap

- [x] Local cloud engineering workstation configuration
- [x] Terraform installation and configuration
- [x] AWS CLI configuration
- [x] Azure CLI configuration
- [x] GitHub CLI authentication
- [x] AWS IAM Identity Center authentication
- [x] Temporary AWS assumed-role authentication
- [x] AWS Terraform provider configuration
- [x] AWS VPC architecture
- [x] Public subnet
- [x] Private application subnet
- [x] Management subnet
- [x] AWS Internet Gateway
- [x] Public route table and Internet routing
- [x] Terraform outputs
- [x] Terraform format and validation workflow
- [x] Terraform plan review
- [x] AWS infrastructure deployment
- [x] Independent AWS infrastructure verification
- [x] Git repository initialization
- [x] GitHub repository creation
- [ ] GitHub Actions Terraform CI pipeline
- [ ] Infrastructure security scanning
- [ ] GitHub OIDC authentication to AWS
- [ ] AWS security groups
- [ ] AWS compute layer
- [ ] Azure Terraform infrastructure
- [ ] Azure identity and networking
- [ ] Reusable Terraform modules
- [ ] Remote Terraform state
- [ ] Monitoring and logging
- [ ] Multi-cloud architecture documentation

## Current Status

### Phase 1 - AWS Networking Foundation: Complete

The AWS networking foundation has been:

**Designed -> Defined as Code -> Validated -> Planned -> Reviewed -> Deployed -> Verified -> Version Controlled**

The deployed environment currently contains eight Terraform-managed AWS networking resources.

### Next Phase

**GitHub Actions CI/CD and DevSecOps Automation**

The next phase will introduce automated Terraform validation and security controls so infrastructure changes can be checked automatically through GitHub before deployment.