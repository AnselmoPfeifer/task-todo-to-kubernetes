variable "region" {
  default = "us-east-1"
}

variable "ami" {
  #default = "m4.large"
  default = "t2.small"
}

variable "role_description" {
  default = "role to access the EKS resources"
}

variable "label" {
  default = "task-todo"
}