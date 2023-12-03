variable "basename" {
  type    = string
  default = ""
}

variable "basetags" {
  type    = map(any)
  default = {}
}

variable "iam_policies" {
  type    = list(any)
  default = []
}

variable "descriptor" {
  type    = string
  default = ""
}

variable "role_id" {
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