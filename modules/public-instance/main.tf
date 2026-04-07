
locals {
  name = var.name
  clb_id = var.create ? concat(module.clb.*.clb_id, [""])[0] : ""
}

module "clb" {
  count = var.create ? 1 : 0

  source = "../.."
  clb_name                     = local.name
  network_type                 = "OPEN"
  vpc_id                       = var.clb.vpc_id
  address_ip_version = try(var.clb.address_ip_version, null)
  subnet_id                    = null
  security_groups              = try(var.clb.sg_ids, null)
  load_balancer_pass_to_target = try(var.clb.load_balancer_pass_to_target, true)

  create_listener              = false
  create_listener_rules        = false
  dynamic_vip = try(var.clb.dynamic_vip, false)

  # Handling Internet-related parameters that may be empty
  internet_bandwidth_max_out = try(var.clb.internet_bandwidth_max_out, null)
  internet_charge_type       = try(var.clb.internet_charge_type, null) //TRAFFIC_POSTPAID_BY_HOUR, BANDWIDTH_POSTPAID_BY_HOUR and BANDWIDTH_PACKAGE.
  bandwidth_package_id = try(var.clb.bandwidth_package_id, null)

  # Availability Zone Processing
  master_zone_id = try(var.clb.master_zone_id, null)
  slave_zone_id  = try(var.clb.slave_zone_id, null)

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