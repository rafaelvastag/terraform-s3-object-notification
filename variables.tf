variable "name" {
  description = "Bucket unique name. It may contain only numbers, letters and dash"
  type        = string
}
variable "acl" {
  description = "Access Control List. It defines which AWS Accounts or Groups are grated access and the type of access"
  type        = string
  default     = "private"
}
variable "policy" {
  description = "Bucket policy"
  type        = string
  default     = null
}
variable "force_destroy" {
  description = "Enable force destroy"
  type        = bool
  default     = false
}
variable "tags" {
  description = "Bucket Tags"
  type        = map(string)
  default     = {}
}
variable "key_prefix" {
  description = "Prefix to put your key(s) inside the bucket. E.g: logs -> all files will be uploaded under logs/ path .."
  type        = string
  default     = ""
}
variable "filepath" {
  description = "The local path where the desired files will be uploaded to the bucket"
  type        = string
  default     = ""
}
variable "versioning" {
  description = "Map containing versioning config"
  type        = map(string)
  default     = {}
}
variable "website" {
  description = "Map containing website config"
  type        = map(string)
  default     = {}
}
variable "logging" {
  description = "Map containing logging config"
  type        = map(string)
  default     = {}
}
variable "notification_topic" {
  description = "List of maps containing topic notification config"
  type        = list(map(string))
  default     = []
}
variable "notification_queue" {
  description = "List of maps containing queue notification config"
  type        = list(map(string))
  default     = []
}
variable "notification_lambda" {
  description = "List of maps containing lambda notification config"
  type        = list(map(string))
  default     = []
}