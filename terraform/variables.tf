variable "region" {
  default = "us-east-1"
}

variable "role_name" {
  default = "role-task-todo"
}

variable "role_description" {
  default = "role to access the EKS resources"
}

variable "cluster_name" {
  default = "task-todo-cluster"
  type    = "string"
}

variable "label" {
  default = "task-todo"
}