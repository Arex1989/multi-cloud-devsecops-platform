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
|   EC2 Web Tier
|
+-- Private Application Subnet
|   10.20.10.0/24
|   No direct Internet Gateway route
|
+-- Management Subnet
    10.20.20.0/24
    SSM / Management Connectivity
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
- Web and application security groups
- Dedicated VPC endpoint security group
- Controlled ingress and egress rules
- Amazon EC2 web tier using Amazon Linux 2023 ARM64
- `t4g.micro` EC2 compute instance
- Encrypted GP3 EBS storage
- IMDSv2 enforced on the EC2 instance
- IAM role and instance profile for EC2
- AWS Systems Manager integration
- Amazon S3 Gateway VPC Endpoint
- SSM Interface VPC Endpoint
- SSM Messages Interface VPC Endpoint
- Nginx web service deployed and validated
- Standardized Terraform resource tagging
- Terraform outputs for infrastructure IDs
- IAM Identity Center authentication for local administration
- GitHub OIDC federation for CI/CD authentication
- Remote Terraform state using Amazon S3

All deployed AWS infrastructure is managed through Terraform rather than manual resource creation.

## AWS Compute Layer

The project now includes a Terraform-managed Amazon EC2 web tier.

The EC2 implementation includes:

- Amazon Linux 2023
- ARM64 architecture
- `t4g.micro` instance type
- Encrypted GP3 root volume
- IMDSv2 enforcement
- Dedicated security group
- Terraform-managed IAM instance profile
- AWS Systems Manager integration
- Automated Nginx web server deployment
- Infrastructure tagging for environment, project, tier, and management ownership

The EC2 instance is managed as Infrastructure as Code and participates in the same Terraform validation and GitHub Actions CI workflow as the networking layer.

## AWS Systems Manager

The EC2 web tier is integrated with AWS Systems Manager (SSM).

A dedicated IAM role and instance profile provide the EC2 instance with the required Systems Manager permissions.

Private AWS service connectivity is supported through:

- SSM Interface VPC Endpoint
- SSM Messages Interface VPC Endpoint
- Amazon S3 Gateway VPC Endpoint

The SSM Agent was successfully verified as:

```text
Online
```

This provides an AWS-native management path for the EC2 instance without depending exclusively on direct SSH administration.

## Nginx Web Tier Validation

Nginx was installed and configured on the Amazon Linux 2023 EC2 instance through AWS Systems Manager.

The service was verified as:

```text
active
enabled
```

Local HTTP validation returned:

```text
HTTP/1.1 200 OK
Server: nginx
```

The deployed web page identifies the workload as:

```text
Multi-Cloud DevSecOps Platform
AWS web tier - Terraform managed
```

This validates the complete path from Terraform-managed compute provisioning through Systems Manager administration to application service availability.

## Infrastructure as Code Workflow

The infrastructure workflow follows:

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
AWS CLI / SSM Verification
```

This workflow ensures infrastructure changes are formatted, validated, reviewed, deployed, and independently verified.

## Identity and Access Management

### Local Administration

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

This avoids storing long-lived AWS access keys locally or in the project repository.

### GitHub Actions OIDC Authentication

GitHub Actions authenticates to AWS using OpenID Connect federation.

```text
GitHub Repository
       |
       v
GitHub Actions
       |
       v
GitHub OIDC Token
       |
       v
AWS STS
       |
       v
GitHub Actions IAM Role
       |
       v
Terraform / AWS APIs
```

This eliminates the need to store permanent AWS access keys as GitHub secrets.

The GitHub Actions role uses a dedicated least-privilege read policy for Terraform infrastructure refresh and planning.

The CI role has controlled read access to resources required by the deployed Terraform configuration, including:

- VPCs and VPC attributes
- Subnets
- Route tables
- Internet Gateways
- Security groups
- Security group rules
- VPC endpoints
- Prefix lists
- Network interfaces
- EC2 instances
- EC2 instance types
- EC2 instance attributes
- EC2 tags
- EBS volumes
- EC2 credit specifications
- IAM roles
- IAM instance profiles
- GitHub OIDC provider information

This policy was iteratively validated against the live Terraform state until the CI pipeline could successfully refresh and plan the complete deployed AWS infrastructure.

## Remote Terraform State

Terraform state has been migrated from local storage to an Amazon S3 backend.

The backend provides:

- Centralized remote state
- S3 encryption
- Versioning
- Public access blocking
- Native Terraform state locking
- CI/CD access through AWS OIDC
- Separation of infrastructure state from the Git repository

Local Terraform state files and provider working directories are excluded from source control.

## GitHub Actions DevSecOps Pipeline

The project includes an automated GitHub Actions CI pipeline for Terraform infrastructure validation.

The current workflow is:

```text
Git Push / Pull Request
          |
          v
Checkout Repository
          |
          v
Setup Terraform
          |
          v
Configure AWS Credentials
          |
          v
GitHub OIDC Authentication
          |
          v
Verify AWS OIDC Identity
          |
          v
Verify AWS Network Read Access
          |
          v
Terraform Format Check
          |
          v
Terraform Init
          |
          v
Terraform Validate
          |
          v
Terraform Plan
          |
          v
Trivy IaC Security Scan
          |
          v
CI Validation Passed
```

The complete workflow has been successfully validated against the deployed AWS environment.

### Current CI Status

```text
AWS OIDC Authentication          PASSED
AWS OIDC Identity Verification   PASSED
AWS Network Read Access          PASSED
Terraform Format Check           PASSED
Terraform Init                   PASSED
Terraform Validate               PASSED
Terraform Plan                   PASSED
Trivy IaC Security Scan          PASSED
GitHub Actions Workflow          PASSED
```

## Security Practices

The project currently implements:

- AWS IAM Identity Center authentication
- Temporary assumed-role credentials
- GitHub OIDC federation
- No long-lived AWS access keys in GitHub
- Least-privilege AWS IAM permissions for CI
- Terraform state excluded from Git
- Sensitive `.tfvars` files excluded from Git
- Encrypted and versioned remote Terraform state
- S3 public access blocking
- Native Terraform state locking
- Private subnet isolation
- Controlled public routing through an Internet Gateway
- Dedicated security groups
- Controlled ingress and egress rules
- VPC endpoint-based AWS service connectivity
- Encrypted EC2 EBS storage
- IMDSv2 enforcement
- AWS Systems Manager integration
- Infrastructure tagging for governance and ownership
- Terraform plan review before deployment
- Independent AWS API verification after deployment
- Automated Terraform validation through GitHub Actions
- Trivy Infrastructure-as-Code security scanning
- CI failure on HIGH/CRITICAL security findings
- Automatic public IPv4 assignment disabled at the subnet level
- Git-based infrastructure change management

The platform now integrates automated IaC security scanning, GitHub OIDC federation, least-privilege CI access, remote Terraform state, and automated infrastructure validation.

Future phases will extend these controls across Microsoft Azure and introduce additional policy, monitoring, reusable modules, and multi-cloud governance capabilities.

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
|       +-- terraform-ci.yml
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
|   |   +-- backend.tf
|   |   +-- compute-iam.tf
|   |   +-- compute.tf
|   |   +-- main.tf
|   |   +-- oidc.tf
|   |   +-- outputs.tf
|   |   +-- providers.tf
|   |   +-- security-groups.tf
|   |   +-- variables.tf
|   |   +-- versions.tf
|   |   +-- vpc-endpoints.tf
|   |   +-- .terraform.lock.hcl
|   |
|   +-- azure/
|
+-- bootstrap/
|
+-- .gitignore
+-- README.md
```

Local Terraform state and provider working directories are intentionally excluded from source control.

## Technology Stack

- Terraform
- Amazon Web Services (AWS)
- Microsoft Azure
- Amazon EC2
- Amazon VPC
- Amazon EBS
- Amazon S3
- AWS IAM
- AWS IAM Identity Center
- AWS Systems Manager
- AWS STS
- AWS VPC Endpoints
- Git
- GitHub
- GitHub Actions
- GitHub OIDC
- Trivy
- Nginx
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
- [x] GitHub Actions Terraform CI pipeline
- [x] Infrastructure security scanning with Trivy
- [x] Automated HIGH/CRITICAL IaC security quality gate
- [x] Security finding remediation and CI verification
- [x] GitHub OIDC authentication to AWS
- [x] AWS security groups
- [x] AWS compute layer
- [x] EC2 IAM role and instance profile
- [x] AWS Systems Manager integration
- [x] S3 Gateway VPC Endpoint
- [x] SSM Interface VPC Endpoint
- [x] SSM Messages Interface VPC Endpoint
- [x] Encrypted EC2 EBS storage
- [x] IMDSv2 enforcement
- [x] Nginx web-tier deployment
- [x] Remote Terraform state
- [x] Least-privilege AWS IAM for CI
- [x] Encrypted and versioned S3 Terraform backend
- [x] Native S3 state locking
- [x] Automated Terraform plan in GitHub Actions
- [x] GitHub Actions live AWS infrastructure refresh
- [x] End-to-end Terraform CI validation
- [x] Successful Trivy security validation
- [ ] Azure Terraform infrastructure
- [ ] Azure identity and networking
- [ ] Reusable Terraform modules
- [ ] Monitoring and logging
- [ ] Multi-cloud architecture documentation

## Current Status

### Phase 1 - AWS Networking Foundation: Complete

The AWS networking foundation has been:

**Designed -> Defined as Code -> Validated -> Planned -> Reviewed -> Deployed -> Verified -> Version Controlled**

The deployed environment establishes the networking foundation for the multi-cloud platform, including subnet segmentation, Internet connectivity, routing, and Terraform-managed infrastructure configuration.

### Phase 2 - Terraform CI and IaC Security: Complete

GitHub Actions automatically validates Terraform infrastructure changes and performs Trivy Infrastructure-as-Code security scanning.

During implementation, the security pipeline identified automatic public IPv4 assignment on the AWS public subnet as a security misconfiguration.

The Terraform configuration was remediated, the change was reviewed through `terraform plan`, deployed in-place to AWS, independently verified through the AWS CLI, and successfully revalidated by the CI security pipeline.

The security pipeline performs:

- Terraform formatting verification
- Terraform initialization
- Terraform configuration validation
- Trivy Infrastructure-as-Code security scanning
- CI failure on HIGH/CRITICAL security findings
- Automated security validation on pushes and pull requests

**Security remediation lifecycle:**

`Detect -> Analyze -> Remediate -> Plan -> Deploy -> Verify -> Re-scan -> Pass`

### Phase 3 - GitHub OIDC and Secure AWS CI/CD Integration: Complete

GitHub Actions authenticates to AWS through OpenID Connect federation using short-lived AWS credentials, eliminating the need for long-lived AWS access keys in GitHub.

Terraform state has been migrated from local storage to a private Amazon S3 backend with encryption, versioning, public access blocking, and native state locking.

The GitHub Actions pipeline performs:

- AWS OIDC authentication
- AWS identity verification
- Terraform formatting verification
- S3 remote backend initialization
- Terraform configuration validation
- Live AWS infrastructure refresh
- Automated Terraform plan
- Trivy Infrastructure-as-Code security scanning

The GitHub Actions IAM role follows least-privilege principles and contains the AWS read and Terraform state permissions required by the CI pipeline.

**Secure CI/CD workflow:**

`Push/PR -> GitHub OIDC -> AWS STS -> S3 Remote State -> Terraform Validate -> Terraform Plan -> Trivy Security Scan -> Pass`

### Phase 4 - AWS Compute, Systems Management and Private Service Connectivity: Complete

The AWS environment has been extended beyond the networking foundation with a Terraform-managed compute layer and secure AWS service connectivity.

The implementation includes:

- Amazon EC2 web-tier instance running Amazon Linux 2023 ARM64
- `t4g.micro` compute architecture
- Encrypted GP3 EBS storage
- IMDSv2 enforcement
- Dedicated EC2 IAM role and instance profile
- AWS Systems Manager integration
- Amazon S3 Gateway VPC Endpoint
- SSM Interface VPC Endpoint
- SSM Messages Interface VPC Endpoint
- Dedicated VPC endpoint security controls
- Nginx installation and service configuration
- HTTP service validation
- Terraform-managed compute and IAM resources

AWS Systems Manager connectivity was successfully validated against the EC2 instance.

The Nginx web service was successfully installed, enabled, started, and validated with an HTTP `200 OK` response.

During CI integration, Terraform required additional read permissions to refresh the deployed AWS resources. The GitHub Actions IAM policy was incrementally extended using least-privilege permissions for the specific AWS APIs required by Terraform.

The resulting GitHub Actions workflow successfully completed the full infrastructure validation pipeline.

### Phase 4 Final Validation

```text
Set up job                         PASSED
Checkout repository               PASSED
Setup Terraform                   PASSED
Configure AWS credentials         PASSED
Verify AWS OIDC identity          PASSED
Verify AWS network read access    PASSED
Terraform Format Check            PASSED
Terraform Init                    PASSED
Terraform Validate                PASSED
Terraform Plan                    PASSED
Trivy IaC Security Scan           PASSED
Complete job                      PASSED
```

**AWS CI/CD milestone status: COMPLETE**

The AWS infrastructure, Terraform configuration, remote state, IAM policies, and GitHub Actions pipeline are synchronized and successfully validated.


### Phase 5 – Azure Compute and Secure Workload Deployment: Complete

The Azure compute layer has been successfully implemented using Terraform Infrastructure as Code.

The deployment includes:

- Azure Linux virtual machine deployment
- Secure SSH key-based authentication
- Restricted administrative SSH access through Azure Network Security Groups
- Managed System Assigned Identity
- Static Azure Public IP assignment
- Azure Network Interface configuration
- Ubuntu 24.04 LTS operating system deployment
- Automated Nginx web server installation and validation

The Azure workload was validated through multiple independent checks:

- Terraform plan verification
- Terraform apply deployment
- Azure CLI resource verification
- SSH authentication using ED25519 keys
- Linux system validation
- Nginx service validation
- Local HTTP health check returning HTTP 200

The completed Azure workflow:

`Terraform Code -> Azure VNet -> NSG Security Controls -> Linux VM -> SSH Key Authentication -> Nginx Deployment -> Application Verification`

The Azure compute architecture now demonstrates secure cloud workload provisioning following Infrastructure as Code and DevSecOps principles.

## Current Status

### Phase 6 – Azure CI/CD, Identity and Multi-Cloud Integration: Complete

The Azure environment has been integrated into the project's CI/CD and Infrastructure-as-Code workflow using GitHub Actions, Azure OpenID Connect federation, Azure RBAC, and remote Terraform state.

The implementation includes:

- GitHub Actions authentication to Azure using OIDC
- Microsoft Entra application and service principal integration
- Federated identity credential for the GitHub main branch
- Resource-group scoped Azure Contributor RBAC for CI/CD
- Azure Terraform remote state using Azure Storage
- HTTPS-only storage access with TLS 1.2
- Private `tfstate` container for Terraform state
- GitHub repository variables for Azure configuration
- Secure injection of the Azure SSH public key into Terraform CI
- Automated Azure Terraform initialization and validation
- Automated Terraform plan against live Azure infrastructure
- Azure CLI infrastructure verification

The Azure CI/CD workflow was independently validated through GitHub Actions with a successful end-to-end run.

### Azure CI/CD Validation

```text
Set up job                        PASSED
Checkout repository               PASSED
Setup Terraform                   PASSED
Azure Login with OIDC             PASSED
Terraform Init                    PASSED
Terraform Format Check            PASSED
Terraform Validate                PASSED
Terraform Plan                    PASSED
Azure CLI Verification            PASSED
Complete job                      PASSED


## Phase 7 — Reusable AWS Terraform Modules

### Status: Complete

Phase 7 refactored the existing AWS infrastructure into reusable Terraform modules while preserving the deployed infrastructure and Terraform state.

### AWS Network Module

The AWS networking layer was migrated into:

`modules/aws/network/`

The reusable network module manages:

- VPC
- Public subnet
- Private application subnet
- Management subnet
- Internet Gateway
- Public route table
- Internet route
- Public subnet route-table association

Terraform `moved` blocks were used to migrate existing resources into the module without destroying or recreating the live infrastructure.

### AWS Security Module

The AWS security layer was migrated into:

`modules/aws/security/`

The reusable security module manages:

- Web security group
- Application security group
- VPC interface endpoint security group
- HTTP and HTTPS ingress rules
- Web-to-application traffic rules
- S3 endpoint access
- Security-group egress rules

Existing security resources were migrated into the module using Terraform state-aware refactoring.

### Phase 7 Validation

The refactor was validated against the existing AWS environment.

```text
Terraform validation: PASSED
Network module migration: PASSED
Security module migration: PASSED
Infrastructure recreation: NONE
Final Terraform plan: NO CHANGES
Resources added: 0
Resources changed: 0
Resources destroyed: 0