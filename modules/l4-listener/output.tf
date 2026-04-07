
output "clb_listener_ids" {
  description = "listener ids"
  value       = { for k, listener in tencentcloud_clb_listener.listener : k => listener.listener_id }
}

output "clb_listener_names" {
  description = "listener ids"
  value       = { for k, listener in tencentcloud_clb_listener.listener : k => listener.listener_name }
}