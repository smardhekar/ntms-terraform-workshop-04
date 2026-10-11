variable "env" {
  type    = string
  default = "dev"
}

variable "location" {
  type    = string
  default = "eastus"
}

variable "project-owner" {
  type    = string
  default = "samir"
}

variable "admin_username" {
  type    = string
  default = "vmadmin"
}

variable "vm_count" {
  type    = number
  default = 2
}

