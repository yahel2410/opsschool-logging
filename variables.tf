variable "aws_account_id" {
  type = string
}
variable "aws_region" {
  type = string
}
variable "aws_profile" {
  type    = string
  default = "default"
}
variable "ssh_key_name" {
  type = string
}
variable "prefix_name" {
  type = string
}
variable "instance_count" {
  type    = number
  default = 1
}