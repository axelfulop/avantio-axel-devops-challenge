variable "env" {
    default = "dev"
}

variable "profile" {
    default = "default"
}

variable "region" {
    default = "us-east-1"
}

variable "basetags" {
    type    = map(any)
    default = {}
}
