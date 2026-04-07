
locals {
  clb_customized_config_v2_id = var.create ? concat(tencentcloud_clb_customized_config_v2.config.*.config_id, [""])[0] : ""
  config_name = var.config_name
  bind_list = [ for v in var.bind_list: v if var.create ]
}

resource "tencentcloud_clb_customized_config_v2" "config" {

  count = var.create ? 1 : 0
  config_content = replace(trimsuffix(replace(var.config_content, "\r\n", "\n"), "\n"), "\n", "\r\n")  # "client_max_body_size 224M;\r\nclient_body_timeout 60s;"
  config_name    = local.config_name
  config_type    = var.config_type # "SERVER" or "LOCATION"
}

resource "tencentcloud_clb_customized_config_attachment" "attachments" {
  config_id = local.clb_customized_config_v2_id
  dynamic "bind_list" {
    for_each = local.bind_list
    content {
      load_balancer_id = bind_list.value.load_balancer_id# "lb-g1miv1ok"
      listener_id      = bind_list.value.listener_id # "lbl-9bsa90io"
      location_id      = var.config_type == "SERVER" ? null : bind_list.value.location_id
      domain           = bind_list.value.domain # "demo1.com"
    }
  }
}