variable "region" {
  type    = string
  default = "ap-jakarta"
}

variable "create" {
  type =bool
  default =  true
  description = "create or not"
}

variable "clb_id" {
  description = "load balancer id"
  type = string
}

variable "clb_listeners" {
  description = "see `tencentcloud_clb_listener`"
  default = {}
  type = any
}

