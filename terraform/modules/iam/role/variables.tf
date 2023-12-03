variable "basename" {
  type    = string
  default = ""
}

variable "basetags" {
  type    = map(any)
  default = {}
}

variable "env" {
  type    = string
  default = ""
}

variable "region" {
  type    = string
  default = ""
}

variable "descriptor" {
  type    = string
  default = ""
}

variable "custom_iam_policies" {
  type = list(
    object({
      aws_resource = string
      statements = list(
        object({
          actions   = optional(list(string), [])
          effect    = string
          resources = optional(list(string), ["*"])
          conditions = optional(list(
            object({
              test     = string
              variable = string
              values   = list(string)
            })
          ), [])
        })
      )
    })
  )
  default = []
}

variable "legacy_iam_policies" {
  type    = list(any)
  default = []
}

variable "assume_role_policy" {
  type    = map(any)
  default = {}
}