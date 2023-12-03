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

variable "basetags" {
  type    = map(any)
  default = {}
}

variable "descriptor" {
  type    = string
  default = ""
}

variable "role_arn" {
  type    = string
  default = ""
}

variable "private_subnet_ids" {
  type    = list(string)
  default = []
}

variable "public_subnet_ids" {
  type    = list(string)
  default = []
}

variable "enable_private_access" {
  type = bool
  default = false
}

variable "enable_public_access" {
  type = bool
  default = true
}

variable "cluster_role_arn" {
  type = string
  default = ""
}

variable "nodes_role_arn" {
  type = string
  default = ""
}

variable "node_groups" {
  type = list(map(any))
  default = []
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
