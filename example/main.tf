provider "aws" {
  region = "eu-west-1"
}

module "container_definition_a" {
  source         = "../modules/container_definition"
  name           = "hello-a"
  image          = "tutum/hello-world"
  mem_soft_limit = 256
  port_mappings  = [{
    containerPort = 80
    hostPort      = 80
  }]
}

module "container_definition_b" {
  source         = "../modules/container_definition"
  name           = "hello-b"
  image          = "tutum/hello-world"
  mem_soft_limit = 256
  port_mappings  = [{
    containerPort = 80
    hostPort      = 90
  }]
}

module "task_definition" {
  source                = ".."
  name                  = "mytask"
  container_definitions = [
    "${module.container_definition_a.json}",
    "${module.container_definition_b.json}"]
}
