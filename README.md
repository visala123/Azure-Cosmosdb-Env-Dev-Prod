# Azure-CosmosDB-Env

This repository provides an automated, modular, and environment-specific approach to provisioning Azure CosmosDB resources using Terraform, with CI/CD managed via GitHub Actions.

## Project Structure

```
terraform/
  environments/
    dev/
      backend.tf
      main.tf
      variables.tf
      terraform.tfvars
    prod/
      backend.tf
      main.tf
      variables.tf
      terraform.tfvars
  modules/
    cosmosdb/
      main.tf
      outputs.tf
      variables.tf
.github/
  workflows/
    deploy.yml
```

### 1. Modules

- **modules/cosmosdb/**: Contains reusable Terraform code for deploying CosmosDB and its resource group.
  - `main.tf`: Defines the CosmosDB account and resource group.
  - `variables.tf`: Declares input variables for the module (e.g., resource group name, location, account name, failover, tags, etc.).
  - `outputs.tf`: Exposes the CosmosDB account name as an output.

### 2. Environments

- **environments/dev/** and **environments/prod/**: Each environment has its own set of configuration files.
  - `backend.tf`: Configures remote state storage in Azure for each environment.
  - `main.tf`: Instantiates the CosmosDB module with environment-specific variables.
  - `variables.tf`: Declares variables used in the environment.
  - `terraform.tfvars`: (Not shown, but typically contains values for variables.)

### 3. CI/CD Workflow

- **.github/workflows/deploy.yml**: Automates Terraform plan, cost estimation, and apply steps.

---

## Deployment Process

### 1. Plan and Cost Estimate

- On push to the `stage` branch or via manual dispatch, the workflow:
  - Checks out the code.
  - Sets up Terraform and Azure authentication.
  - Initializes Terraform in the correct environment directory.
  - Validates the configuration.
  - Runs `terraform plan` and saves the plan.
  - Uploads the plan as an artifact.
  - Runs Infracost to estimate the cost of the planned changes and uploads the report.

### 2. Apply (with Approval)

- The `apply` job runs only if manually triggered and the user confirms by typing `yes`.
- Downloads the plan artifact.
- Initializes Terraform.
- Applies the plan, provisioning or updating resources in Azure.

---

## Explanation of `deploy.yml`

- **Triggers**: Runs on push to `stage` or via manual dispatch (with environment and confirmation inputs).
- **Jobs**:
  - **plan**:
    - Sets up the environment and working directory based on the selected environment (`dev` or `prod`).
    - Authenticates to Azure using secrets.
    - Runs Terraform init, validate, and plan.
    - Uploads the plan and cost report as artifacts.
    - Uses Infracost to provide a cost breakdown.
  - **apply**:
    - Requires manual approval and confirmation.
    - Downloads the plan artifact.
    - Authenticates to Azure.
    - Runs Terraform apply using the saved plan.

---

## How to Use

1. **Configure Variables**: Edit `terraform.tfvars` in each environment folder with your desired values.
2. **Push Changes**: Commit and push to the `stage` branch, or trigger the workflow manually.
3. **Review Plan and Cost**: The workflow will output a plan and cost estimate.
4. **Apply Changes**: Manually trigger the workflow with `confirm_apply: yes` to apply the changes.

---

## Collaboration & Approval Setup


### 1. Add Collaborators

1. Go to your repo → **Settings** → **Collaborators**
2. Click "Invite a collaborator"
3. Enter your teammate’s GitHub username
4. Choose appropriate access (usually Write or Admin)
5. Send invite

> **Note:** If you're the owner, you cannot add yourself — you already have full access.

### 2. Add a GitHub Environment for Manual Approval

1. Go to **Settings** → **Environments**
2. Click "New environment", name it (e.g., `dev-approval`)
3. Under "Deployment protection rules", click "Required reviewers"
4. Add your GitHub username (or a teammate)
5. Click Save

This will enforce manual approval before applying infrastructure.

> **Tip:** You can use this for both `dev` and `prod` environments, and add multiple reviewers if needed.

---

## References

- [Terraform Azure Provider](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs)
- [GitHub Actions: Environments and Approvals](https://docs.github.com/en/actions/deployment/targeting-different-environments/using-environments-for-deployment)
