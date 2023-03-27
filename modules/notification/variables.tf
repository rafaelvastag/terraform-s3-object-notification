variable "bucket" {
  description = "Bucket name to create the notification with"
  type        = string
}
variable "bucket_arn" {
  description = "Bucket arn to create the notification"
  type        = string
}
variable "topic" {
  description = "List of maps containing topic configuration"
  type        = list(map(string))
  default     = []
}
variable "queue" {
  description = "List of maps containing queue configuration"
  type        = list(map(string))
  default     = []
}
variable "lambda_function" {
  description = "List of maps containing lambda configuration"
  type        = list(map(string))
  default     = []
}