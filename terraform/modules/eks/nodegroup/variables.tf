variable "basename" {
  type    = string
  default = ""
}

variable "env" {
  type    = string
  default = ""
}

variable "region" {
  type    = string
  default = ""
}

variable "desired_size" {
  type    = number
  default = 1
}

variable "max_size" {
  type    = number
  default = 1
}

variable "min_size" {
  type    = number
  default = 1
}

variable "basetags" {
  type    = map(any)
  default = {}
}

variable "descriptor" {
  type    = string
  default = ""
}

variable "id" {
  type    = string
  default = ""
}

variable "node_groups" {
  type = list(map(any))
  default = []
}

variable "cluster_name" {
  type = string
  default = ""
}

variable "nodes_role_arn" {
  type = string
  default = ""
}

variable "subnet_ids" {
  type    = list(string)
  default = []
}