# AWS VPC Infrastructure with Terraform

This directory contains Terraform configuration for setting up a `highly available` Virtual Private Cloud (VPC) in AWS. The infrastructure is designed to support scalable and secure application deployments.

![AWS VPC Diagram](https://ercanermis.com/wp-content/uploads/aws_vpc.png)


## Components

### 1. VPC
- **Virtual Private Cloud (VPC)**: A custom VPC that provides network isolation and control over your AWS resources.

### 2. Subnets
- **Public Subnets**: 
  - 2 public subnets spread across different Availability Zones to ensure high availability.
  - Designed for resources that need direct access to the internet, such as load balancers and bastion hosts.

- **Private Subnets**:
  - 2 private subnets also spread across different Availability Zones.
  - Used for internal resources like application servers and databases that should not be exposed directly to the internet.

- **Database Subnets:**
2 database subnets spread across different Availability Zones.
Designed specifically for hosting database instances in private subnets restricting to be exposed directly to the internet.

### 3. Internet Gateway
- **Internet Gateway**: Attached to the VPC, enabling outbound internet access for resources in the public subnets.

### 4. NAT Gateway
- **NAT Gateway**: 
  - Deployed in one of the public subnets to provide outbound internet access for resources in the private subnets.
  - An `Elastic IP` is allocated to the NAT Gateway to ensure a static, public IP address.

### 5. Route Tables
- **Public Route Table**:
  - Routes traffic from the public subnets to the Internet Gateway, allowing resources in these subnets to communicate with the internet.
  - Automatically associated with the public subnets.

- **Private Route Table**:
  - Routes traffic from the private subnets to the NAT Gateway, allowing resources in these subnets to access the internet without being exposed to it.
  - Specifically associated with the private subnets to maintain a secure network environment.


## Terraform Concepts Used
- 1. **Resource Block:** Most fundamental block to create resources in any cloud provider.
- 2. **Variables:** Defines input parameters for your Terraform configurations.
- 3. **Locals:**  Used to assign values to local variables, which can simplify complex expressions.
- 4. **Data Source:** Used to query existing information about AWS resources, such as availability zones
- 5. **Dynamic Subnets Creation:** The `count` parameter is used in resource blocks to create multiple instances of a resource dynamically. This is particularly useful for creating subnets across multiple availability zones Example: Creating public subnets dynamically based on the number of availability zones:
    ```hcl
    resource "aws_subnet" "public_subnets" {
      count = length(data.aws_availability_zones.azs.names)

      vpc_id            = aws_vpc.backend_vpc.id
      cidr_block        = var.public_subnets[count.index]
      availability_zone = data.aws_availability_zones.azs.names[count.index]

      tags = {
        Name = "public-subnet-${data.aws_availability_zones.azs.names[count.index]}"
      }
    }
    ```


## Usage

1. Clone the repository:
   ```bash
  git clone https://github.com/saeedalig/AWS-Terraform.git
  cd vpc
  ```

2. Initialize Terraform:
  ```bash
  terraform init
  ```
3. Plan the configuration:
  ```bash
  terraform plan
  ```

4. Apply the configuration:
  ```bash
  terraform apply
  ```

