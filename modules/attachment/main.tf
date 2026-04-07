
locals {
  targets = { for k ,target in var.targets: k => target if var.create }
}


resource "tencentcloud_clb_attachment" "attachments" {
  count = length(local.targets) > 0 ? 1 : 0
  clb_id   = var.clb_id
  listener_id = var.listener_id # "lbl-hh141sn9"
  domain      = var.rule_id == null ? var.domain : null
  rule_id     = var.rule_id
  url         = var.rule_id == null ? var.url : null

  dynamic "targets" {
    for_each = local.targets
    content {
      eni_ip = try(targets.value.eni_ip, null) # "172.16.16.52"
      instance_id = try(targets.value.eni_ip, null) != null ? null : try(targets.value.instance_id, null)
      port   = targets.value.port
      weight = try(targets.value.weight, 10)
    }
  }
}