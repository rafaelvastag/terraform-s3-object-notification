resource "aws_s3_bucket_notification" "this" {
  count = length(var.topic) == 0 && length(var.queue) == 0 && length(var.lambda_function) == 0 ? 0 : 1

  bucket = var.bucket

  dynamic "topic" {
    for_each = length(var.topic) == 0 ? [] : var.topic
    content {
      id            = lookup(topic.value, "id", null)
      topic_arn     = lookup(topic.value, "topic_arn", null)
      events        = split(",", lookup(var.topic, "events", ""))
      filter_prefix = lookup(var.topic, "filter_prefix", null)
      filter_suffix = lookup(var.topic, "filter_suffix", null)
    }
  }

  dynamic "queue" {
    for_each = length(var.queue) == 0 ? [] : var.queue
    content {
      id            = lookup(queue.value, "id", null)
      queue_arn     = lookup(queue.value, "topic_arn", null)
      events        = split(",", lookup(var.queue, "events", ""))
      filter_prefix = lookup(var.queue, "filter_prefix", null)
      filter_suffix = lookup(var.queue, "filter_suffix", null)
    }
  }

  dynamic "lambda_function" {
    for_each = length(var.lambda_function) == 0 ? [] : var.lambda_function
    content {
      id                  = lookup(lambda_function.value, "id", null)
      lambda_function_arn = lookup(lambda_function.value, "topic_arn", null)
      events              = split(",", lookup(var.lambda_function, "events", ""))
      filter_prefix       = lookup(var.lambda_function, "filter_prefix", null)
      filter_suffix       = lookup(var.lambda_function, "filter_suffix", null)
    }
  }
}

resource "aws_lambda_permission" "this" {

  for_each = length(var.lambda_function) == 0 ? {} : {
    for i, r in var.lambda_function : i => r
  }
  statement_id  = "AllowExecutionFromS3Bucket${each.key}"
  action        = "lambda:InvokeFunction"
  function_name = lookup(each.value, "lambda_function_arn", null)
  principal     = "s3.amazonaws.com"
  source_arn    = var.bucket_arn
}