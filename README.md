# Deployed Architecture
![alt text](https://rahul2611.s3.amazonaws.com/terraform-deployment.jpg)

# Terrafrom

Terraform is a tool for building, changing, and versioning infrastructure safely and efficiently. Terraform can manage existing and popular service providers as well as custom in-house solutions.

Configuration files describe to Terraform the components needed to run a single application or your entire datacenter. Terraform generates an execution plan describing what it will do to reach the desired state, and then executes it to build the described infrastructure. As the configuration changes, Terraform is able to determine what changed and create incremental execution plans which can be applied.

## Installing

### MAC OS
```
$brew install terraform  
```
Verify the installation
```
$terraform version  
```
# How to run Demo project
### clone git repo
Clone git repo in your computer
```
git clone https://github.com/rahulit1991/terraform-demo.git
```
### generate SSH key pair
Once repo clone, switch into repo and generate key pair using following command:
```
ssh-keygen -f <keypair-name> 
```
### Rename SSH key pair
Once Keypair generated, rename private key it with extention
```
mv <keypair-name> <keypair-name>.pem
```
### Generate AWS_ACCESS_KEY and AWS_SECRET_KEY
Generate programmatic Access using this link:
```
https://docs.aws.amazon.com/IAM/latest/UserGuide/id_users_create.html#id_users_create_console
```
### update terraform.tfvars file
create terraform.tfvars file with following variables and assign approprate values:
```
- AWS_REGION
- AWS_ACCESS_KEY
- AWS_SECRET_KEY
- vpc-cidr-block
- key_path
- az1
- az2
- az3
- public-subnet1
- public-subnet2
- public-subnet3
- private-subnet1
- private-subnet2
- private-subnet3
```
### Init configuration
Initialize provider before apply configuration. move into project directory and run below command
```
$terraform init  
```
Note: above command required only once for particular directory.It may takes 5-10 minutes to complete successfully.
### Plan Configuration

Before apply changes. best practice, plan terraform configuration
```
$terraform plan  
```
### Apply Configuration
Apply configuration for deploy infrastructure
```
$terraform apply  
```
### Output terraform deployment
Note output of this command.
```
$terraform output 
```
### SSH into Bastion Instance (For MAC)
```
ssh-add -K <keypair-name>.pem 
ssh -A ubuntu@<instance_eip>
```
## Destroy Configuration
If you want to destroy all configuration please run below command:
```
$terraform destroy  
```
Note: this command not recommanded. if you run this command it will remove all deployment at once.
