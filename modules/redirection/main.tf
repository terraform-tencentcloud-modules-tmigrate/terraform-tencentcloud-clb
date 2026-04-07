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
}