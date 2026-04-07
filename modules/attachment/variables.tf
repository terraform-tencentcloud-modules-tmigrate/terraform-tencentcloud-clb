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
  default = null
}

variable "targets" {
  default = {}
  type = any
  description = "target of clb, see `tencentcloud_clb_attachment`"
}

variable "listener_id" {
  type = string
  default = null
  description = " ID of the CLB listener."
}
variable "rule_id" {
  type = string
  default = null
  description = "ID of the CLB listener rule. Only supports listeners of HTTPS and HTTP protocol."
}
variable "domain" {
  type = string
  default = null
  description = "Domain of the target forwarding rule. Does not take effect when parameter rule_id is provided."
}
variable "url" {
  type = string
  default = null
  description = "URL of the target forwarding rule. Does not take effect when parameter rule_id is provided."
}

