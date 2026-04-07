variable "region" {
  type    = string
  default = "ap-jakarta"
}

variable "create" {
  type        = bool
  default     = true
  description = "create or not"
}

variable "clb_id" {
  description = "load balancer id"
  type        = string
}

variable "redirections" {
  description = "see `tencentcloud_clb_redirection`"
  default     = {}
  type        = any
}
