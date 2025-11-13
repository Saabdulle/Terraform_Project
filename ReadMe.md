# Project README

## Overview

This project provisions a complete AWS environment using Terraform, including a Virtual Private Cloud (VPC), three microservices (Lighting, Heating, and Status), a shared DynamoDB backend, and an Application Load Balancer (ALB). The infrastructure follows the required architecture and ensures secure, scalable deployment across multiple Availability Zones.

## VPC Configuration

* **Region**: Deployed to the specified AWS region.
* **Availability Zones**: Spans **three** AZs for high availability.
* **Subnets**:

  * **Public subnets**: One per AZ.
  * **Private subnets**: One per AZ.
* **Internet Gateway (IGW)**: Provides outbound internet access for public subnets.
* **Route Tables**:

  * Local routes within the VPC.
  * Default route forwarding external traffic through the IGW.

## Security Groups

Security groups are configured to:

* Allow inbound HTTP and HTTPS traffic from external sources.
* Permit outbound internet access as required.
* Enable restricted SSH access from your IP address.

## Lighting Service

* Fully deployed and externally accessible.
* Integrated with DynamoDB.
* **IAM Users & Roles**:

  * An IAM user with DynamoDB permissions and CLI access (credentials stored in environment files).
  * A dedicated IAM role allowing the service to access the DynamoDB table.

## Heating Service

* Fully deployed and externally accessible.
* Integrated with DynamoDB for persistent storage.

## Status Service

* Fully deployed and externally accessible.
* Aggregates data from the Lighting and Heating services and exposes a unified endpoint.

## Application Load Balancer

A single ALB provides path-based routing to each service, removing the need for multiple load balancers and simplifying traffic management.

## Autoscaling

Each service uses an autoscaling group defined in `terraform.tfvars`, specifying:

* Minimum, maximum, and desired instance counts
* Instance type
* AMI ID(s)

Autoscaling ensures availability and cost-efficiency during varying workloads.

## `terraform.tfvars` Example

Ensure your `terraform.tfvars` file includes values similar to the following:

```hcl
public_subnets     = ["10.0.7.0/24", "10.0.8.0/24", "10.0.9.0/24"]
private_subnets    = ["10.0.10.0/24", "10.0.11.0/24", "10.0.12.0/24"]
availability_zones = ["eu-west-2a", "eu-west-2b", "eu-west-2c"]
cidr_block         = "10.0.0.0/16"
instance_type      = "t2.micro"
key_name           = "key_name"
server_count       = 1
table_names        = ["Lights-Table", "Heating-Table"]
table_tags         = ["Lights_Table", "Heating_Table"]
server_names       = ["Lights", "Heating", "Status"]
min_size           = 1
max_size           = 5
desired_size       = 2
ami_images         = ["ami", "ami", "ami"]  # Replace with actual AMI IDs
```

Replace placeholder values with your actual configuration parameters.

## Deployment

To deploy the infrastructure:

1. Confirm Terraform is installed locally.

2. In the project directory, run:

   ```bash
   terraform init
   terraform plan
   terraform apply
   ```

3. When prompted, type **yes** to proceed.

4. Wait for Terraform to complete provisioning.

### Destroying the Environment

To remove all resources created by Terraform:

```bash
terraform destroy
```

## Additional Notes

* Keep sensitive data (e.g., IAM credentials, environment files) secure and **never commit them to version control**.
* Validate that AMI IDs and region-specific settings are correct before deploying.
