variable "bucket" {
  type = string
}

variable "acl" {
  type    = string
  default = "private"
}

variable "tags" {
  type    = map(string)
  default = {}
}