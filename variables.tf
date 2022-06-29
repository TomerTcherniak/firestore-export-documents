variable "project" {
  type        = string
  description = "The ID of the project to which resources will be applied."
}

variable "service_account" {
  type        = string
  description = "The service account which the function will applied"
}

variable "region" {
  type        = string
  description = "The region in which resources will be applied."
}

variable "runtime" {
  type        = string
  description = "The runtime in which resources will be applied."
}

variable "bucketname" {
  type        = string
  description = "The bucket in which resources will be applied."
}

variable "collections" {
  type        = string
  description = "The bucket in which resources will be applied."
}

variable "backup_bucket" {
  type        = string
  description = "The bucket in which resources will be applied."
}
