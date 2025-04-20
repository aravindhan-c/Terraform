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
