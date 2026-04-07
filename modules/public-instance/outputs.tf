output "clb_id" {
  description = "clb id"
  value = local.clb_id
}

output "clb_name" {
  value = local.name
}

output "clb_vips" {
  description = "The virtual service address table of the CLB."
  value       = var.create ? module.clb[0].clb_vips : []
}

output "clb_domain" {
  description = "Domain name of the CLB instance."
  value       = var.create ? module.clb[0].clb_domain : ""
}