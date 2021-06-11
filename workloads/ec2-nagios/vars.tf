variable "type_instance" {
  description = "type of instance"
  type        = string
}


variable "key_ssh_name" {
  description = "ssh instance .pem"
  type        = string
}

variable "type_volume" {
  description = "type volume instance"
  type        = string
}

variable "size_volume" {
  description = "Size volume"
  type        = number
}

variable "del_on_termination" {
  description = "Delete block storage"
}

