locals {
  clb_listeners = { for k, l in var.clb_listeners: k => l if var.create}
}


resource "tencentcloud_clb_listener" "listener" {
  for_each = local.clb_listeners
  clb_id   = var.clb_id

  // TODO: naming convention
  listener_name              = each.value.listener_name
  port                       = each.value.port
  protocol                   = each.value.protocol
  certificate_ca_id          = lookup(each.value, "certificate_ca_id", null)
  certificate_id             = lookup(each.value, "certificate_id", null)
  certificate_ssl_mode       = lookup(each.value, "certificate_ssl_mode", null)
  health_check_context_type  = lookup(each.value, "health_check_context_type", null)
  health_check_health_num    = lookup(each.value, "health_check_health_num", null)
  health_check_http_code     = lookup(each.value, "health_check_http_code", null)
  health_check_http_domain   = lookup(each.value, "health_check_http_domain", null)
  health_check_http_method   = lookup(each.value, "health_check_http_method", null)
  health_check_http_path     = lookup(each.value, "health_check_http_path", null)
  health_check_http_version  = lookup(each.value, "health_check_http_version", null)
  health_check_interval_time = lookup(each.value, "health_check_interval_time", null)
  health_check_port          = lookup(each.value, "health_check_port", null)
  health_check_recv_context  = lookup(each.value, "health_check_recv_context", null)
  health_check_send_context  = lookup(each.value, "health_check_send_context", null)
  health_check_switch        = lookup(each.value, "health_check_switch", null)
  health_check_time_out      = lookup(each.value, "health_check_time_out", null)
  health_check_type          = lookup(each.value, "health_check_type", null)
  health_check_unhealth_num  = lookup(each.value, "health_check_unhealth_num", null)
  scheduler                  = lookup(each.value, "scheduler", null)
  session_expire_time        = lookup(each.value, "session_expire_time", null)
  sni_switch                 = lookup(each.value, "sni_switch", null)
  target_type                = lookup(each.value, "target_type", null)
  session_type = lookup(each.value, "session_type", null)
  keepalive_enable = lookup(each.value, "keepalive_enable", null)
  health_source_ip_type = lookup(each.value, "health_source_ip_type", null)
  h2c_switch = lookup(each.value, "h2c_switch", null) # Enable H2C switch for intranet HTTP listener.
  snat_enable = lookup(each.value, "snat_enable", true) # - (Optional, Bool) Whether to enable SNAT.
}