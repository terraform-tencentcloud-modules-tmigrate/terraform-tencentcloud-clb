
output "clb_listener_ids" {
  description = "listener ids"
  value       = { for k, listener in tencentcloud_clb_listener.listener : k => listener.listener_id }
}

output "clb_listener_names" {
  description = "listener ids"
  value       = { for k, listener in tencentcloud_clb_listener.listener : k => listener.listener_name }
}

output "clb_listener_rule_ids" {
  value = { for k, rule in tencentcloud_clb_listener_rule.listener_rule : k => rule.rule_id }
}

output "clb_listener_rule_domains" {
  value = { for k, rule in tencentcloud_clb_listener_rule.listener_rule : k => join(",", rule.domains) }
}

output "clb_listener_rule_urls" {
  value = { for k, rule in tencentcloud_clb_listener_rule.listener_rule : k => rule.url }
}

output "https_rule_iap_resources" {
  value = [ for domain in local.https_domains: format("qcs::clbia::uin/%s:clb/%s/%s/https/%s/%s" ,data.tencentcloud_user_info.this.owner_uin, var.clb_id, domain.port  ,domain.domain, tencentcloud_clb_listener_rule.listener_rule[domain.rule_k].rule_id ) ]
}