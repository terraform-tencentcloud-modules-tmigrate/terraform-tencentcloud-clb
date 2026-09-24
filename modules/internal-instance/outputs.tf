output "clb_id" {
  description = "clb id"
  value = local.clb_id
}

output "clb_name" {
  value = local.name
}

output "clb_vips" {
  value = local.clb_vips
}

output "numerical_vpc_id" {
  description = "Numerical Id of the VPC (used by monitor alarm binding dimensions)."
  value       = var.create ? concat(module.clb.*.numerical_vpc_id, [0])[0] : 0
}