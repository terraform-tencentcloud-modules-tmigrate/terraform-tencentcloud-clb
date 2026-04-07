variable "region" {
  type    = string
  default = "ap-jakarta"
}

variable "create" {
  type =bool
  default =  true
  description = "create or not"
}

variable "config_name" {
  type = string
  default = ""
  description = "Name of Customized Config."
}
variable "config_content" {
  type = string
  default = ""
  description = "Content of Customized Config."
}
variable "config_type" {
  type = string
  default = ""
  description = "Type of Customized Config. Valid values: SERVER and LOCATION"
}
variable "bind_list" {
  type = any
  default = []
  description = "clb list to bind this config"
}