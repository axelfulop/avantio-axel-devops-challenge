resource "aws_s3_bucket" "terraform_state_bucket" {
    bucket = "${var.env}-${var.region}-avantio-terraform-state"
}
