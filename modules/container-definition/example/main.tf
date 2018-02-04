provider "aws" {
  region = "eu-west-1"
}

module "container_definition" {
  source         = ".."
  name           = "hello-world"
  image          = "tutum/hello-world"
  mem_soft_limit = 256
  port_mappings  = [{
    containerPort = 80
    hostPort      = 80
  }]
}

output "container_definition_json" {
  value = "${module.container_definition.json}"
}