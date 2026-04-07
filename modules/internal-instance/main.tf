
locals {
  name = var.name
  clb_id = var.create ? concat(module.clb.*.clb_id, [""])[0] : ""
  clb_vips = var.create ? concat(module.clb.*.clb_vips, [[]])[0] : []
}


module "clb" {
  count = var.create ? 1 : 0

  source = "git::https://github.com/terraform-tencentcloud-modules/terraform-tencentcloud-clb.git?ref=master"
  clb_name                     = local.name
  network_type                 = "INTERNAL"
  vpc_id                       = var.clb.vpc_id
  subnet_id                    = var.clb.subnet_id
  vip = try(var.clb.vip, null)
  security_groups              = try(var.clb.sg_ids, null)
  load_balancer_pass_to_target = try(var.clb.load_balancer_pass_to_target, true)

  create_listener              = false
  create_listener_rules        = false

  sla_type = try(var.clb.sla_type, null)
  snat_pro = try(var.clb.snat_pro, null)

  # logs
  create_clb_log = try(var.clb.create_clb_log, false)
  clb_log_set_period = try(var.clb.clb_log_set_period, null)
  clb_log_topic_name = try(var.clb.clb_log_topic_name, null)
  log_set_id = try(var.clb.log_set_id, null)
  log_topic_id = try(var.clb.log_topic_id, null)

  project_id = try(var.clb.project_id, 0)
  tags                         = var.tags

}

resource "tencentcloud_clb_snat_ip" "foo" {
  count = var.create && try(var.clb.snat_ips, []) != [] ? 1 : 0
  clb_id = local.clb_id
  dynamic "ips" {
    for_each = try(var.clb.snat_ips, [])
    content {
      subnet_id = ips.value.subnet_id # "subnet-12345678"
      ip        = ips.value.ip # "172.16.0.1"
    }
  }
}