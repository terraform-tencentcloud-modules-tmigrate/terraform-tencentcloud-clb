locals {
  redirections = {
    for k, redirection in var.redirections: k => redirection if var.create
  }
}

resource "tencentcloud_clb_redirection" "clb_redirection" {
  for_each                   = local.redirections
  clb_id                  = var.clb_id
  target_listener_id      = each.value.target_listener_id
  target_rule_id          = each.value.target_rule_id
  delete_all_auto_rewrite = try(each.value.delete_all_auto_rewrite, null)
  is_auto_rewrite         = try(each.value.is_auto_rewrite, null)
  source_listener_id      = try(each.value.is_auto_rewrite, null) == true ? null : try(each.value.source_listener_id, null)
  source_rule_id          = try(each.value.is_auto_rewrite, null) == true ? null : try(each.value.source_rule_id, null)
  rewrite_code            = try(each.value.rewrite_code, null)
  take_url                = try(each.value.take_url, null)
  # source_domian 仅在手动重定向（is_auto_rewrite = false）时有效，配置 rewrite_code 时为必填
  source_domian = try(each.value.is_auto_rewrite, null) == true ? null : try(each.value.source_domian, null)
}