# Terraform
Terraform

Challenges with traditional IT infrastructure
* Slow deployment
* Exepensive
* Limited automation
* Human error
* Inconsistency
* Wasted resources

IAC - Infrastructure as Code

* Configuration management 
  * Designed to install and manage software
  * Maintains standard structure
  * version control
  * idempotent
  * Anisble, pupper, saltstack
* Server templating
  * Pre install s/w and dependencies
  * virtual machine or docker images
  * immutable infrastructure
  * Docker, Packer, Vagrant
* Provisioning toos -
  * Deploy immutable infrastructure resources
  * servers, dbs, n/w components
  * Multiple providers
  * Terraform, CloudFormation

Terraform
  * Infrastructure provisioning tool
  * Uses HCL - Hashicorp configuration language (Declarative language)
  * files are saved in .tf extension
  * Phases in terraform - Init, plan, apply
  * Resource - every object that terraform manages
  * Terraform state
      * Terraform maintains the state of the infra in .tfstate file
      * State is a blueprint of the infra deployed by terraform

HCL

  * Have block and block arguments
  * Block name - resource
  * Resource type - fixed key word defined by the providers
  * Resource name - can be anything
  * Arguments
  *  resource "aws_ec2" "webserver" {ami:"ami-0232340" instance_type="t2.micro"}

Terraform steps

  * Write configuration file
  * run init command
  * review execution plan with terrafom plan
  * apply the changes with terraform apply

Terraform commands
  * terraform init
  * terraform plan
  * terraform apply
  * terraform show
  * terraform destroy

Terraform providers
  * terrafrom init - terraform download & install the plugins of the providers mentioned in the configuration file
  * terraform providers are available at registry.terraform.io
  * There are 3 tiers of providers
      * Official providers - owned and managed by hashicorp - local, aws, gcp, azure
      * Partner provider - owned and managed by 3rd party technology companies through partner process with hashicop
      * Community providers

Configuration directory
  * single configuration file is recommended
  * main.tf - main configuration file containing the resource definition
  * variables.tf - contains variables declarations
  * outputs.tf - contains outputs from resources
  * providers.tf - contains provider definition


Terrafrom input variables
 * It is the best practice to use variable in variables.tf instead of hard coding in main.tf
 * we can declare the variable/argument in variables.tf and use them in main.tf
 * variable block arguments - default, type, description
    * type - string, number, bool, any, list, map, object, tuple, set
    * if type is not specified it will take any type

Using variables in terraform
 * If we didn't give any default values in the variables in variables.tf we will be asked to enter it while executing terraform appply
 * We can also give it like terraform apply -var "filenanme=/root/my.txt" -var "content=We like pets!"
 * Environment variables - $ export TF_VAR_filename ="/root/pet.txt"
 * We can also create *.tfvars/*.auto.tfvars/*.auto.tfvars.jsob file - eg. terraform.tfvars - terraform apply -var-file terraform.tfvars
 * Variable precedent - environment variable -> terraform.tfvars -> *.auto.tfvars (alpa ordera) -> -var or -var-file (will be the highest priority and override any values defined above)

Resource attributes
content = "My favourite per is ${random_pet.pet.id}"

Resource dependencies
 * Implicit dependency - terraform finds it by default as we don't mention anything
 * Explicit dependency - explicitly defining the dependency via depend_on

Output variables
* used for displaying provitioned resource details or to pass the output values to other IAC tools
output "variable-name"{
value = "variable expression"}

Terraform state

* When we run terrafom apply it will create the terrafom.tfstate file containing all the details about the provisioned infrastructure
* It is a non-optional feature
* Data in terraform.tfstate file is made of plain json format
* Purpose
   * Tracking metadata - required while deleting data
   * Performance - terraform plan --refresh=false
   * collaboration b/w teams
 
Terraform commands
 * terraform validate - to check syntax
 * terraform fmt - change the format for more readable
 * terraform show - show current state of the resource
 * terraform show -j - in json format
 * terraform providers - providers used in the configuration directory
 * terraform providers mirror /etc/file - mirror the provider configuration in new file
 * terraform output - for output
 * terraform apply -refresh-only
 * terraform graph - to view the configuration in graph format

Mutable and immutable infrastructure
 * Mutabe infrastructure - Existing infrastructure remains but we can do changes like s/w upgrades etc
 * Configuration drift - upgrade can fail for few servers and versions can differ in different servers
 * Immutable infrastructure - configuration drift can be avoided, delete the resource and create it with new configs

Lifecycle rules 
lifecycle{
   create_before_destroy = true
}
 * resource will be created before deletion
 * prevent_destroy = true - resources will not be deletion after the config updates
 * ignore_changes - ignore changes to resource attributes

Data sources
 * Allows terraform to read attributes created outside the terraform
![image](https://github.com/user-attachments/assets/4ffa7eb2-7262-4112-9aef-b31390fc4c86)

Meta arguments
 * count - creates number of resources mentioned as count - resources are created in list type
 * length function - calculate the size of the list
 * for_each - resources are created in map type

version constrains
 * we can install specific version of the plugin we can use terraform block in the configuration file

Remote state
 * uses of state file
    * mapping configurations to the real world
    * Tracking metadata
    * Performance
    * Collaboration
  * terraform state lock protects the configuration file from multiple operations at the same time thereby putting the state locks
  * terraform state file is stored in remote state backend
  * we can configure terraform backend with s3 bucket for state file storage and dynamo db for locks storage

Terraform state commands
 * allows to list, pull and manipulate the state files
 * terraform state list [options] [address]
 * terraform state list aws.s3.bucket.finance-22020922
 * terraform state show aws.s3.bucket.finance-22020922
 * terraform state mv aws_dynamodb_table.state-locking aws_dynamodb_table.state-locking-table
 * terraform state pull
 * terraform state rm aws_se_bucket.finance-2020922 - resource removed from state files are not actual destroyed in real world

Terrafom provisioners
 * Provisioner contains set of scripts or command that run while creating or destruction of resources
 * remote-exec
 * local-exec
 * creation-time provisioner
 * destroy-time provisioner
 * Failure behaviour - if the provisioner fails by default the terraform apply command will also fail. to overcome this we can use on_fial = continue in the provisioner so the terraform will mark the resource block for the provision as tainted and apply will run successfully
 * Best practice - avoid using provisioner instead use user_date. Instead user_data we can use the ami with required s/w. It the built-in ami doesn't have those s/w use custom ami or ami packager


 Terraform taint
  * using taint we can forcefully destroy and re-create a resource even there is no infrastructure change during the next terraform apply command
  * terraform taint aws_instance.webserver
  * terraform untaint aws_instance.webserver

  Terraform debugging
  * log levels - info, warning, error, debug, trace
  * we can set env. variable for logging
  * $ export TF_LOG = TRACE
  * $ export TF_LOG_PATH - /temp/terraform.log
  * $ unseT TF_LOG

Terraform import
   * terraform import <resource_type>.<resource.name> <attributes>
   * while running first time we will get error as it update the state file not the config file
   * write a empty resource block for the above resource in main.tf and then import

Terraform modules
 * modules allows to create resources in multiple directories with the single configuration directory.
 * module "dev-webserver"{
    source = "../aws-instance/"
    key = "webserver"
   }
 * module "iam_iam-user" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-user"
  version = "5.28.0"
  # insert the 1 required variable here
  name = "max"
  create_iam_access_key = false
  create_iam_user_login_profile = false
}
 * importing modules from registry
   * terraform module contains both provider plugins & modules
   * verified modules
   * community modules
   * terraform get - to download only the modules from the registry
  
Terraform function
 * terraform console - interactive console - provided by terraform - we can use it to test functions
 * Numeric functions - max(), min(), max(var.num...) - expansion symbol to use variable as argument in function, ceil(), floor()
 
<img width="853" alt="image" src="https://github.com/user-attachments/assets/94e8a948-8c32-45b5-b271-c48212989ac6" />

 * String function - split(), lower(), upper(), title(), substr(), join()
<img width="708" alt="image" src="https://github.com/user-attachments/assets/e799094c-314a-49d7-b145-33e0bd00e081" />

 * Collection functions - length(), index(), element(), contains()
<img width="548" alt="image" src="https://github.com/user-attachments/assets/d76b742c-8a03-4a04-889d-b96e0200901e" />

  * Map fuctions - keys(), values(), lookup()
<img width="545" alt="image" src="https://github.com/user-attachments/assets/6e3db576-4b54-4261-9ecd-d7966a4e8e23" />

Operators & conditional expressions
 * In terraform console we can also perform mathematical operations
 * Operators - arithmetic, eqality, comparison, logical
 * Conditional expression - condition ? true_val : false_val

Terraform workspace
 * terraform workspace new projectA
 * terraform workspace list
 * terraform workspace select projectB
