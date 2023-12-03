locals {
  basename = "${var.env}-${var.region}"

}

resource "aws_sqs_queue" "queue" {
  name = "${local.basename}-${var.queue_name}"

  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.dead_letter_queue.arn,
    maxReceiveCount     = 3
  })

  depends_on = [
    aws_sqs_queue.dead_letter_queue
  ]
}


resource "aws_sqs_queue" "dead_letter_queue" {
  name = "${local.basename}-${var.dead_letter_queue_name}"
}

resource "aws_sns_topic" "topic" {
  count = var.aws_sns_topic_name != "" ? 1 : 0
  name = "${local.basename}-${var.aws_sns_topic_name}"
}

resource "aws_sns_topic_subscription" "rover_updates_subscription" {
  count = var.aws_sns_topic_name != "" ? 1 : 0
  topic_arn = aws_sns_topic.topic[count.index].arn
  protocol  = "sqs"
  endpoint  = aws_sqs_queue.queue.arn
}