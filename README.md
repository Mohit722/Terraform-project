# Infrastructure as Code (IaC) Project

This repository contains Terraform code for provisioning and managing AWS infrastructure using reusable modules. The project includes configurations for setting up an Elastic Load Balancer (ELB) and an Auto Scaling Group (ASG) with EC2 instances, all organized into separate environments (dev, staging, prod).


# Project Purpose and Advantages

This Terraform project is designed to automate the provisioning and management of scalable web applications on AWS using Infrastructure as Code (IaC). The primary components of the project include:

- Elastic Load Balancer (ELB): Distributes incoming application traffic across multiple EC2 instances to ensure high availability and fault tolerance.
- Auto Scaling Group (ASG): Automatically adjusts the number of EC2 instances in response to traffic demands, ensuring that your application can handle varying loads without manual intervention.


# Advantages of Using This Project

1. Scalability: The project enables your application to scale seamlessly based on traffic demands. With ASG, you can automatically add or remove EC2 instances, ensuring optimal resource utilization.

2. High Availability: By integrating an ELB, you ensure that your application remains accessible even during traffic spikes or instance failures. The load balancer reroutes traffic to healthy instances, enhancing the user experience.

3. Cost Efficiency: Auto Scaling allows you to pay only for the resources you need. By automatically adjusting the number of EC2 instances based on demand, you can reduce costs during low-traffic periods while ensuring availability during peak times.

4. Reusability and Modularity: The project is structured using reusable Terraform modules, promoting code reusability and making it easier to manage infrastructure across different environments (development, staging, production).

5. Infrastructure as Code: This approach allows you to version control your infrastructure, making it easier to track changes, collaborate with team members, and roll back to previous states if necessary.


# Use Cases
- Web Applications: Deploy scalable web applications that require load balancing and automatic scaling based on user traffic.
- Microservices Architectures: Manage multiple microservices that need to communicate with each other while being exposed through a unified load balancer.
- Development and Testing: Quickly spin up isolated environments for development and testing purposes, ensuring that the infrastructure mimics production setups closely.
- E-Commerce Sites: Ensure high availability and reliability for online retail platforms, especially during peak shopping seasons.

By utilizing this project, you can efficiently manage your AWS infrastructure, providing a robust foundation for deploying modern applications with scalability and resilience.



# Table of Contents

- [Overview](#overview)
- [Prerequisites](#prerequisites)
- [Directory Structure](#directory-structure)
- [Configuration](#configuration)
- [Running Terraform](#running-terraform)
- [Best Practices](#best-practices)
- [Contributing](#contributing)

# Overview

The main goal of this project is to automate the provisioning of AWS infrastructure using Terraform. The project structure is designed to allow for easy modifications and reuse of Terraform modules across different environments.


# Prerequisites

Before you begin, ensure you have the following installed:

1. Terraform: Version 1.0 or later.
2. AWS CLI: Configured with appropriate permissions to create and manage resources in your AWS account.


# Directory Structure
The directory structure of the project is as follows:


.
├── README.md              # Project documentation
├── modules/               # Contains reusable Terraform modules
│   ├── network/           # Network module for creating security groups
│   ├── elb/               # ELB module for provisioning Elastic Load Balancers
│   └── asg/               # ASG module for creating Auto Scaling Groups
└── environments/          # Environment-specific configurations
    ├── dev/               # Development environment
    │   ├── main.tf        # Main configuration file for the dev environment
    │   ├── variables.tf   # Variables used in the dev environment
    │   └── terraform.tfvars # Terraform variable values for the dev environment
    ├── staging/           # Staging environment (structure similar to dev)
    └── prod/              # Production environment (structure similar to dev)




# Configuration

Before running the Terraform code, you need to configure your environment settings:

1. Navigate to the Environment: Choose the environment you want to deploy (dev, staging, or prod).
   ```bash
   cd environments/dev  # Change to your desired environment
   ```

2. Edit `terraform.tfvars`: Replace the placeholder values with your actual AWS resource IDs in the `terraform.tfvars` file.

   ```hcl
   # terraform.tfvars

   vpc_id            = "your-vpc-id"             # Your actual VPC ID
   subnet_ids        = ["subnet-xxxxxxx", "subnet-yyyyyyy"] # Your actual Subnet IDs
   custom_ami_id     = "ami-xxxxxxxx"             # Your custom AMI ID for the instances
   instance_type     = "t2.micro"                 # Type of EC2 instance
   elb_port          = 80                          # ELB listening port
   server_port       = 8080                        # Server port on EC2 instances
   ```



# Cloning the Repository

Clone the repository to your local machine:

```bash
git clone https://github.com/Mohit722/Terraform-project.git
cd your-repo-name
```


# Steps to Run Terraform

1. Navigate to Your Environment:
   ```bash
   cd environments/dev  # Or any other environment folder
   ```

2. Initialize Terraform:
   This command initializes the working directory containing the Terraform configuration files. It downloads the required provider plugins.
   ```bash
   terraform init
   ```

3. Plan Your Changes:
   This command shows you the changes Terraform will make to your infrastructure. It reads variables from `terraform.tfvars`.
   ```bash
   terraform plan -var-file="terraform.tfvars"
   ```

4. Apply Your Changes:
   This command applies the planned changes to your AWS account, creating the necessary resources.
   ```bash
   terraform apply
   ```


# Best Practices

- Version Control: Use Git to manage changes to your Terraform configuration files.
- Environment Isolation: Use separate environments for development, staging, and production to avoid conflicts and ensure stability.
- Reuse Modules: Leverage the modular structure to avoid duplicating code and maintain consistency across environments.
- Documentation: Keep your documentation up to date with any changes made to the modules or configurations.



# Running Terraform with Jenkins Pipeline

This project can be integrated with Jenkins to automate the deployment and management of your infrastructure using Terraform. Below are the steps to set up a Jenkins pipeline that executes Terraform commands.


# Steps to Run Terraform in a Jenkins Pipeline

1. Set Up Jenkins:
   - Ensure you have [Jenkins](https://www.jenkins.io/doc/book/installing/) installed and running.
   - Install the required plugins:
     - Pipeline: For creating Jenkins pipelines.
     - Terraform: For running Terraform commands directly from Jenkins.

2. Create a New Jenkins Pipeline Job:
   - Go to your Jenkins dashboard.
   - Click on "New Item" and select "Pipeline".
   - Give your pipeline a name and click "OK".

3. Configure the Pipeline:
   - In the pipeline configuration, you can use a `Jenkinsfile` to define your pipeline stages. You can place the `Jenkinsfile` in the root of your Git repository or directly in the pipeline configuration in Jenkins.


# Example Jenkinsfile

Here’s a simple example of a `Jenkinsfile` that runs Terraform commands:


pipeline {
    agent any

    parameters {
        choice(name: 'ACTION', choices: ['create', 'destroy'], description: 'Select whether to create or destroy resources.')
    }

    environment {
        TF_VAR_instance_type = 't2.micro'            // Set your desired instance type
        TF_VAR_custom_ami_id = 'ami-xxxxxxxx'        // Replace with your custom AMI ID
        TF_VAR_elb_port = 80                          // Replace with your ELB port
        TF_VAR_server_port = 8080                     // Replace with your server port
        // Add additional variables as needed
    }

    stages {
        stage('Checkout Code') {
            steps {
                // Checkout the code from your repository
                git 'https://github.com/your-repo.git' // Replace with your repo URL
            }
        }

        stage('Terraform Init') {
            when {
                expression { params.ACTION == 'create' }
            }
            steps {
                // Run Terraform init
                sh 'terraform init'
            }
        }

        stage('Terraform Plan') {
            when {
                expression { params.ACTION == 'create' }
            }
            steps {
                // Run Terraform plan
                sh 'terraform plan -var-file="terraform.tfvars"'
            }
        }

        stage('Terraform Apply') {
            when {
                expression { params.ACTION == 'create' }
            }
            steps {
                // Run Terraform apply
                sh 'terraform apply -var-file="terraform.tfvars" -auto-approve'
            }
        }

        stage('Terraform Destroy') {
            when {
                expression { params.ACTION == 'destroy' }
            }
            steps {
                // Run Terraform destroy
                sh 'terraform destroy -var-file="terraform.tfvars" -auto-approve'
            }
        }
    }

    post {
        success {
            echo "${params.ACTION.capitalize()} operation completed successfully!"
        }
        failure {
            echo "${params.ACTION.capitalize()} operation failed!"
        }
    }
}



# Explanation of the Jenkinsfile

- Agent: Specifies the Jenkins agent where the pipeline will run. `agent any` allows it to run on any available agent.
- Environment: Sets environment variables that will be used in the Terraform commands.
- Stages:
  - Checkout Code: Checks out the code from your Git repository.
  - Terraform Init: Initializes the Terraform workspace.
  - Terraform Plan: Runs `terraform plan` to see what changes will be made.
  - Terraform Apply: Applies the changes with `terraform apply`. The `-auto-approve` flag automatically approves the plan.
- Post Actions: Handles success and failure notifications.

# Triggering the Pipeline

You can configure Jenkins to trigger this pipeline:
- Manually by clicking "Build Now".
- Automatically via webhooks from GitHub for changes in the repository.
- On a schedule using the "Build Triggers" section.


# Benefits of Using Jenkins with Terraform

- Automation: Automate your infrastructure provisioning and management.
- Version Control: Keep your infrastructure code in version control, enabling easier collaboration.
- Consistency: Ensure consistent environments across development, testing, and production.
- Visibility: Monitor your infrastructure changes in the Jenkins dashboard.

This integration allows you to manage and deploy your infrastructure as part of your CI/CD pipeline, streamlining your development and deployment processes.


# Contributing

If you would like to contribute to this project, please follow these steps:

1. Fork the repository.
2. Create a new branch (`git checkout -b feature/YourFeature`).
3. Make your changes and commit them (`git commit -m 'Add some feature'`).
4. Push to the branch (`git push origin feature/YourFeature`).
5. Open a pull request.

Thank you for your contributions!



# License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.



