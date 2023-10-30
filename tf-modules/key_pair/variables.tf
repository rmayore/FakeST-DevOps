variable "app_name" {
  type        = string
  description = "App Name"
}
variable "namespace" {
  type        = string
  description = "Namespace"
}
variable "stage" {
  type        = string
  description = "Stage"
}

variable "ssh_public_key_path" {
  type        = string
  description = "Public Key Path"
}
variable "ssh_public_key_file" {
  type        = string
  description = "Public Key File"
}
