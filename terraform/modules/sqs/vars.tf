variable "queue_name" {
    type    = string
    default = ""
}

variable "dead_letter_queue_name" {
    type    = string
    default = ""
}

variable "aws_sns_topic_name" {
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