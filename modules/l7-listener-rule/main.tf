data "tencentcloud_user_info" "this" {}


locals {

  clb_listeners = { for k, l in var.clb_listeners: k => l if var.create}
  clb_listener_default_domains = { for k, l in local.clb_listeners: k => l if try(l.default_domain, null) != null }

  clb_listener_rules = flatten([
    for listener_k, listener in var.clb_listeners : [
      for idx, rule in try(listener.rules, {}) : merge(rule, {
        k          = format("%s_%s", listener_k, idx)
        listener_k = listener_k
        port = listener.port
        protocol = listener.protocol
      })
    ]
  ])
  clb_listener_rule_map = { for rule in local.clb_listener_rules : rule.k => rule if var.create}

  https_domains = concat(flatten([
    for rule_k, rule in local.clb_listener_rule_map: [
      for domain in try(rule.domains, []): {
        domain = domain
        rule_k = rule_k
        k = format("%s_%s", rule_k, domain)
        port = rule.port
      }
    ] if try(rule.domain, null) == null && rule.protocol == "HTTPS"
  ]),
    [ for rule_k, rule in local.clb_listener_rule_map: {
      domain = rule.domain
      rule_k = rule_k
      k = format("%s_%s", rule_k, rule.domain)
      port = rule.port
    } if try(rule.domain, null) != null  && rule.protocol == "HTTPS" ]
  )

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
  dynamic "multi_cert_info" {
    for_each = lookup(each.value, "multi_cert_info", null) == null ? [] : [1]
    content {
      ssl_mode = try(each.value.multi_cert_info.ssl_mode, "UNIDIRECTIONAL")
      cert_id_list = each.value.multi_cert_info.cert_id_list
    }
  }

  lifecycle {
    ignore_changes = [
      h2c_switch # this can not be changed
    ]
  }
}

resource "tencentcloud_clb_listener_rule" "listener_rule" {
  for_each                   = local.clb_listener_rule_map
  clb_id                     = var.clb_id
  listener_id                = tencentcloud_clb_listener.listener[each.value.listener_k].listener_id
  domain                     = try(each.value.domains, null) == null ? try(each.value.domain, null) : null
  domains                    = try(each.value.domains, null)
  url                        = each.value.url
  certificate_ca_id          = lookup(each.value, "certificate_ca_id", null)
  certificate_id             = lookup(each.value, "certificate_id", null)
  certificate_ssl_mode       = lookup(each.value, "certificate_ssl_mode", null)
  forward_type               = lookup(each.value, "forward_type", null)
  health_check_health_num    = lookup(each.value, "health_check_health_num", null)
  health_check_http_code     = lookup(each.value, "health_check_http_code", null)
  health_check_http_domain   = lookup(each.value, "health_check_http_domain", null)
  health_check_http_method   = lookup(each.value, "health_check_http_method", null)
  health_check_http_path     = lookup(each.value, "health_check_http_path", null)
  health_check_interval_time = lookup(each.value, "health_check_interval_time", null)
  health_check_port          = lookup(each.value, "health_check_port", null)
  health_check_switch        = lookup(each.value, "health_check_switch", null)
  health_check_time_out      = lookup(each.value, "health_check_time_out", null)
  health_check_type          = lookup(each.value, "health_check_type", null)
  health_check_unhealth_num  = lookup(each.value, "health_check_unhealth_num", null)
  http2_switch               = lookup(each.value, "http2_switch", null)
  scheduler                  = lookup(each.value, "scheduler", null)
  session_expire_time        = lookup(each.value, "session_expire_time", null)
  target_type                = lookup(each.value, "target_type", null)
  dynamic "multi_cert_info" {
    for_each = lookup(each.value, "multi_cert_info", null) == null ? [] : [1]
    content {
      ssl_mode = try(each.value.multi_cert_info.ssl_mode, "UNIDIRECTIONAL")
      cert_id_list = each.value.multi_cert_info.cert_id_list
    }
  }
  dynamic "oauth" {
    for_each = lookup(each.value, "oauth", null) == null ? [] : [1]
    content {
      oauth_enable = try(lookup(each.value, "oauth").oauth_enable, true)
      oauth_failure_status = try(lookup(each.value, "oauth").oauth_failure_status, "REJECT") //  BYPASS: PASS; REJECT: Reject.
    }
  }
}
#
#resource "time_sleep" "wait" {
#  depends_on = [tencentcloud_clb_listener_rule.listener_rule]
#
#  create_duration = "10s"
#}

resource "tencentcloud_clb_listener_default_domain" "default" {
  depends_on = [tencentcloud_clb_listener_rule.listener_rule]
  for_each = local.clb_listener_default_domains
  clb_id      = var.clb_id
  listener_id = tencentcloud_clb_listener.listener[each.key].listener_id
  domain      = each.value.default_domain
}
