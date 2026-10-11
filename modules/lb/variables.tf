variable "env" {
  type = string
}

variable "location" {
  type = string
}

variable "project-owner" {
  type = string
}

variable "rg_name" {
  type = string
}

variable "nic_ids" {
  type = list(string)
}

variable "vm_count" {
  type = number
}