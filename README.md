[![CircleCI](https://circleci.com/gh/tieto-cem/terraform-aws-ecs-task-definition.svg?style=shield&circle-token=549ec46ff06d26b4c86715e054bc03ac7f152533)](https://circleci.com/gh/tieto-cem/terraform-aws-ecs-task-definition)

AWS ECS Task Definition Terraform module
===========================================

Terraform module which creates ECS Task Definition. 

Usage
-----   

```hcl

module "container_definition" {
  source         = "github.com/tieto-cem/terraform-aws-ecs-task-definition//modules/container_definition?ref=v0.1.0"
  name           = "hello"
  image          = "tutum/hello-world"
  mem_soft_limit = 256
  port_mappings  = [{
    containerPort = 80
    hostPort      = 80
  }]
}

module "task_definition" {
  source                = "github.com/tieto-cem/terraform-aws-ecs-task-definition?ref=v0.1.0"
  name                  = "mytask"
  container_definitions = [
    "${module.container_definition.json}"]
}

```

Resources
---------

This module creates following AWS resources:

| Name                                        | Type                 | 
|---------------------------------------------|----------------------|
|${var.name}-task-role                        | IAM Role             | 
|/ecs/task/${var.name}                        | Log Group            |
|${var.name}                                  | Task Definition      |

Example
-------

* [Simple example](https://github.com/timotapanainen/terraform-aws-ecs-task-definition/tree/master/example)