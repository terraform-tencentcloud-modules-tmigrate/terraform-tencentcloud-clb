# tencentcloud_clb_listener  L4 CLB Listener

Provides a resource to create L4 CLB listener

Reference: https://registry.terraform.io/providers/tencentcloudstack/tencentcloud/latest/docs/resources/clb_listener


# CLB
Reference:

https://www.tencentcloud.com/document/product/214

https://www.tencentcloud.com/document/product/214/6151?lang=en&pg=


## usage

```hcl
terraform {
  source = "../.."
}


inputs = {
  create        = true

  clb_id = "lb-10qxxxxo"
  clb_listeners = {
    listener_1 = {
      listener_name = "tcp_listener_8888"

      health_check_switch        = true
      health_check_time_out      = 2
      health_check_interval_time = 5
      health_check_health_num    = 3
      health_check_unhealth_num  = 3
      health_check_port          = 200
      health_check_type          = "HTTP"
      health_check_http_code     = 2
      health_check_http_version  = "HTTP/1.0"
      health_check_http_method   = "GET"

      protocol            = "TCP"
      port                = 8888
      session_expire_time = 30
      scheduler           = "WRR"
      session_expire_time = 30
      // set this value to allow a target group to attach
      #      target_type = "TARGETGROUP" # NODE, TARGETGROUP. NODE means to bind ordinary nodes, TARGETGROUP means to bind target group.
    },
    listener_2 = {
      listener_name = "tcp_listener_80"
      protocol      = "TCP"

      health_check_switch = false

      port                = 80
      session_expire_time = 60
      snat_enable = true # default false
    }
  }
}
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12 |
| <a name="requirement_tencentcloud"></a> [tencentcloud](#requirement\_tencentcloud) | >= 1.81.160 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_tencentcloud"></a> [tencentcloud](#provider\_tencentcloud) | >= 1.81.160 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [tencentcloud_clb_listener.listener](https://registry.terraform.io/providers/tencentcloudstack/tencentcloud/latest/docs/resources/clb_listener) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_clb_id"></a> [clb\_id](#input\_clb\_id) | load balancer id | `string` | n/a | yes |
| <a name="input_clb_listeners"></a> [clb\_listeners](#input\_clb\_listeners) | see `tencentcloud_clb_listener` | `any` | `{}` | no |
| <a name="input_create"></a> [create](#input\_create) | create or not | `bool` | `true` | no |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `"ap-jakarta"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_clb_listener_ids"></a> [clb\_listener\_ids](#output\_clb\_listener\_ids) | listener ids |
| <a name="output_clb_listener_names"></a> [clb\_listener\_names](#output\_clb\_listener\_names) | listener ids |
