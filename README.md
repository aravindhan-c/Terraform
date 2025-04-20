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




