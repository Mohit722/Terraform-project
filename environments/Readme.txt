# Execution Instructions:  This project contains separate folders for different environments: `dev`, `staging`, and `prod`. Each environment has its own Terraform configuration files. 


# Directory Structure

environments/
├── dev/
│   ├── main.tf
│   ├── variables.tf
│   └── terraform.tfvars
├── staging/
│   ├── main.tf
│   ├── variables.tf
│   └── terraform.tfvars
└── prod/
    ├── main.tf
    ├── variables.tf
    └── terraform.tfvars



# Switching Directories and Executing Terraform

1. Navigate to the Desired Environment:
   To execute Terraform commands, navigate to the folder corresponding to the desired environment using the terminal:

   ```bash
   cd environments/dev   # For development
   cd environments/staging   # For staging
   cd environments/prod   # For production
   ```

2. Initialize Terraform:
   Before applying any configuration, initialize the Terraform working directory to download the required provider plugins and set up the backend:

   ```bash
   terraform init
   ```

3. Review the Changes:
   After initialization, review the changes Terraform plans to make by running:

   ```bash
   terraform plan
   ```

   This command provides an overview of the resources that will be created, modified, or destroyed.

4. Apply the Configuration:
   Once you're satisfied with the planned changes, you can apply the configuration to provision the resources:

   ```bash
   terraform apply
   ```

   You will be prompted to confirm the changes. Type `yes` to proceed.

5. Tear Down the Environment (Optional):
   If you want to destroy all the resources created by Terraform in the current environment, run:

   ```bash
   terraform destroy
   ```

   Again, confirm by typing `yes`.


# Additional Considerations

- Ensure you have the necessary IAM permissions to create and manage the resources defined in the Terraform configurations.
- Each environment (dev, staging, prod) can have different configurations based on your requirements. Modify the `terraform.tfvars` file in each environment folder to specify environment-specific values.
- It’s good practice to keep your AWS credentials secure and not hard-code them into your Terraform files. Use AWS IAM roles or environment variables to manage access.
