resource "aws_s3_bucket" "this" {
  bucket = var.name
  acl    = var.acl
  policy = var.policy
  tags   = var.tags

  force_destroy = var.force_destroy

  dynamic "versioning" {
    for_each = length(keys(var.versioning)) == 0 ? [] : [var.versioning]
    content {
      enabled    = lookup(versioning.value, "enabled", null)
      mfa_delete = lookup(versioning.value, "mfa_delete", null)
    }
  }

  dynamic "website" {
    for_each = length(keys(var.website)) == 0 ? [] : [var.website]
    content {
      index_document           = lookup(website.value, "index_document", null)
      error_document           = lookup(website.value, "error_document", null)
      redirect_all_requests_to = lookup(website.value, "redirect_all_requests_to", null)
      routing_rules            = lookup(website.value, "routing_rules", null)
    }
  }
  dynamic "logging" {
    for_each = length(keys(var.logging)) == 0 ? [] : [var.logging]
    content {
      target_bucket = lookup(logging.value,"target_bucket", null)
      target_prefix = lookup(logging.value,"target_prefix", null)
    }
  }
}

module "notification" {
  source = "./modules/notification"
  bucket = aws_s3_bucket.this.bucket
  bucket_arn = aws_s3_bucket.this.arn
  lambda_function = var.notification_lambda
  queue = var.notification_queue
  topic = var.notification_topic
}

module "objects" {
  source = "./modules/object"
  bucket = aws_s3_bucket.this.bucket
  filepath = var.filepath
  key_prefix = var.key_prefix
}