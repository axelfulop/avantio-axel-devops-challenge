module "sqs" {

  source = "../../modules/sqs"

  env    = var.env
  region = var.region

  queue_name             = "rover-updates"
  dead_letter_queue_name = "rover-updates-dead-letter"
  aws_sns_topic_name     = "fleet-updates"

}
