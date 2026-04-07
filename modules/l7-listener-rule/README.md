# tencentcloud_clb_listener  L7 CLB Listener

Provides a resource to create L7 CLB listener with rules

Reference: https://registry.terraform.io/providers/tencentcloudstack/tencentcloud/latest/docs/resources/clb_listener


# CLB
Reference:

https://www.tencentcloud.com/document/product/214

https://www.tencentcloud.com/document/product/214/6151?lang=en&pg=


> Note: For GRPC, set h2c_switch = true, and health_check_type = "GRPC", forward_type = "GRPC" under each rule of this listener


## usage

### normal creation

```hcl

terraform {
  source = "../.."
}


inputs = {
  create        = true

  clb_id = "lb-8bzgh623"
  clb_listeners = {
    listener_1 = {
      listener_name = "http_listener"
      protocol = "HTTP"
      port = 80
      default_domain = "80.801.net"
      keepalive_enable = 1 # Whether to enable a persistent connection. This parameter is applicable only to HTTP and HTTPS listeners. Valid values: 0 (disable; default value) and 1 (enable).
      h2c_switch = true # Enable H2C switch for intranet HTTP listener.
      rules = {
        "80.801.net" = {
          #          domain         = "80.foo.net"
          domains         = ["80.801.net", "80.802.net"]
          url            = "/80-foo-edit"
          health_check_switch        = true
          health_check_interval_time = 5
          health_check_health_num    = 3
          health_check_unhealth_num  = 3
          health_check_time_out      = 3
          health_check_http_code     = 2
          health_check_port          = 8888
          health_check_http_path     = "/80-foo"
          health_check_http_domain   = "80.foo.net"
          health_check_http_method   = "GET"
          health_check_type = "GRPC"
          forward_type = "GRPC"
        },
        "80.bar.net" = {
          domain         = "80.bar.net"
          url            = "/80-bar"
          health_check_switch   = false
          forward_type = "GRPC"
        },
      }
    } ,
    listener_2 = {
      listener_name = "http_listener_8080"
      protocol = "HTTPS"
      port = 8080
      default_domain = "default.foo.net"
      certificate_id = "JQx7qjys"
      certificate_ssl_mode = "UNIDIRECTIONAL"
      snat_enable = true # defaut false
      rules = {
        "8080.foo.net" = {
          domains         = ["8080.foo.net", "8080.foo1.net"]
          url            = "/8080-foo"
          health_check_switch        = true
          health_check_http_domain   = "8080.foo.net"
        },
        "default.foo.net" = {
          domain         = "default.foo.net"
          url            = "/8080-foo"
        }
      }
    }
  }

}
```

### with IAP

References: 

https://www.tencentcloud.com/document/product/214/65909

> Note: for https domain IAP resource styles, see outputs.https_rule_iap_resources

``` 
  https_rule_iap_resources  = [
      "qcs::clbia::uin/100009291175:clb/lb-8bzgh623/8080/https/8080.foo.net/loc-hw2eskuj",
      "qcs::clbia::uin/100009291175:clb/lb-8bzgh623/8080/https/8080.foo1.net/loc-hw2eskuj",
      "qcs::clbia::uin/100009291175:clb/lb-8bzgh623/8080/https/default.foo.net/loc-98h3ucnd",
  ]
```

```hcl 
inputs = {
  ...
  clb_listeners {
    ...
    listener_2 = {
      ...
      rules = {
        ...
        "default.foo.net" = {
          domain         = "default.foo.net"
          url            = "/8080-foo"
          oauth = {
            oauth_enable = false      # true: enable, false: disable
            oauth_failure_status = "REJECT" # BYPASS: PASS; REJECT: Reject
          }
        }
      }
    }
  }
}
```

### for multi certs of listener 

```hcl 

inputs = {
  clb_listeners = {
    listener_2 = {
      # this block can be located in listener or in listener rule when you enable SNI
      multi_cert_info = {
        ssl_mode     = "UNIDIRECTIONAL" # "UNIDIRECTIONAL"
        cert_id_list = [
          "KRBg83PP", # RSA ssl certification
          "LCYi9Prc"  # ECC ssl certification
        ]
      }
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
| [tencentcloud_clb_listener_default_domain.default](https://registry.terraform.io/providers/tencentcloudstack/tencentcloud/latest/docs/resources/clb_listener_default_domain) | resource |
| [tencentcloud_clb_listener_rule.listener_rule](https://registry.terraform.io/providers/tencentcloudstack/tencentcloud/latest/docs/resources/clb_listener_rule) | resource |
| [tencentcloud_user_info.this](https://registry.terraform.io/providers/tencentcloudstack/tencentcloud/latest/docs/data-sources/user_info) | data source |

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
| <a name="output_clb_listener_rule_domains"></a> [clb\_listener\_rule\_domains](#output\_clb\_listener\_rule\_domains) | n/a |
| <a name="output_clb_listener_rule_ids"></a> [clb\_listener\_rule\_ids](#output\_clb\_listener\_rule\_ids) | n/a |
| <a name="output_clb_listener_rule_urls"></a> [clb\_listener\_rule\_urls](#output\_clb\_listener\_rule\_urls) | n/a |
| <a name="output_https_rule_iap_resources"></a> [https\_rule\_iap\_resources](#output\_https\_rule\_iap\_resources) | n/a |
