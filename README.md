# Terraform CI/CD Pipeline with GitHub Actions, AWS OIDC & DevSecOps Controls

## Overview

This project demonstrates a production-style Terraform CI/CD pipeline built using GitHub Actions and AWS OIDC authentication. The pipeline follows Infrastructure as Code (IaC) best practices by implementing security scanning, plan/apply separation, environment approvals, artifact promotion, and automated infrastructure deployment

The objective of this project is to create a secure, scalable, and reusable deployment workflow that can be used across multiple environments such as staging and production.

---

## Key Features

### Secure AWS Authentication using OIDC

* No long-lived AWS access keys stored in GitHub.
* GitHub Actions authenticates directly with AWS using OpenID Connect (OIDC).
* IAM Roles are assumed using temporary credentials.

### DevSecOps Security Scanning

Before any Terraform execution, the pipeline performs multiple security checks:

#### Gitleaks

Detects:

* AWS Access Keys
* GitHub Tokens
* SSH Keys
* Hardcoded Secrets
* Credentials committed to source code

#### Checkov

Scans Terraform code for:

* Security misconfigurations
* IAM policy issues
* Encryption violations
* Public exposure risks
* Compliance violations

#### Trivy

Performs Infrastructure-as-Code scanning to detect:

* Critical Terraform misconfigurations
* Security vulnerabilities
* Compliance issues

---

## Pipeline Architecture

```text
Pull Request / Manual Trigger
                │
                ▼
      Security Checks
      ├── Gitleaks
      ├── Checkov
      └── Trivy
                │
                ▼
        Terraform Plan
      ├── terraform fmt
      ├── terraform validate
      ├── terraform plan
      └── Upload Plan Artifact
                │
                ▼
      Environment Approval
          (Production)
                │
                ▼
        Terraform Apply
      ├── Download Plan
      ├── terraform apply
      ├── Export Outputs
      └── Upload Outputs
```

---

## Pull Request Workflow

When a Pull Request is created:

1. Security scans are executed.
2. Terraform validation is performed.
3. Terraform plan is generated.
4. Plan output is automatically posted as a PR comment.
5. Infrastructure changes can be reviewed before deployment.

This enables shift-left security and infrastructure review.

---

## Deployment Workflow

Deployments can be manually triggered using GitHub Actions Workflow Dispatch.

Supported options:

### Dry Run

Generate Terraform plans without applying changes.

### Environment Selection

Deploy to:

* Staging
* Production

### Infrastructure Destroy

Generate and execute a destroy plan when required.

---

## Plan and Apply Separation

The pipeline follows a promotion-based deployment model.

### Plan Stage

* Generates Terraform plan
* Stores plan as a GitHub Artifact

### Apply Stage

* Downloads the previously approved plan
* Applies the exact plan generated earlier

This prevents drift between planning and deployment.

---

## Production Approval Gate

GitHub Environment Protection Rules are used to protect production deployments.

Production deployments require manual approval before execution.

Workflow:

```text
Terraform Plan
      │
      ▼
Manual Approval
      │
      ▼
Terraform Apply
```

This ensures reviewers can inspect planned infrastructure changes before deployment.

---

## Artifact Management

The pipeline stores:

### Terraform Plans

* tfplan
* tfplan-destroy

### Terraform Outputs

* Infrastructure outputs exported as JSON
* Retained for 14 days

---

## Technologies Used

* GitHub Actions
* Terraform
* AWS IAM
* AWS OIDC
* Gitleaks
* Checkov
* Trivy
* GitHub Environments
* GitHub Artifacts

---

## Security Controls Implemented

| Control                                   | Status |
| ----------------------------------------- | ------ |
| OIDC Authentication                       | ✅      |
| Secret Scanning                           | ✅      |
| Terraform Security Scanning               | ✅      |
| Infrastructure Misconfiguration Detection | ✅      |
| Environment Approvals                     | ✅      |
| Artifact Promotion                        | ✅      |
| Plan Review Before Apply                  | ✅      |
| Temporary AWS Credentials                 | ✅      |

---

## Learning Outcomes

This project demonstrates practical experience with:

* CI/CD Pipeline Design
* Infrastructure as Code (Terraform)
* GitHub Actions Workflow Development
* AWS OIDC Federation
* DevSecOps Practices
* Secure Infrastructure Deployment
* Environment-Based Release Management
* Artifact Promotion Strategies
* Production Change Approval Workflows

---

## Future Enhancements

* Multi-account AWS deployments
* Reusable GitHub Actions workflows
* Terraform remote backend automation
* SARIF integration with GitHub Security Dashboard
* Slack/MS Teams deployment notifications
* Policy-as-Code using OPA or Sentinel
* Self-hosted GitHub runners
* EKS deployment integration
* Cost estimation using Infracost

---

Built as a hands-on DevOps/DevSecOps project to demonstrate secure Terraform automation using GitHub Actions and AWS.
