# tencentcloud_clb_listener  redirection 

Provides a resource to create redirection

Reference: https://registry.terraform.io/providers/tencentcloudstack/tencentcloud/latest/docs/resources/clb_redirection


# CLB
Reference:

https://www.tencentcloud.com/document/product/214

https://www.tencentcloud.com/document/product/214/6151?lang=en&pg=


## usage

This will redirect `def.com/bbb` to `abc.com/aaa`

```hcl

terraform {
  source = "../.."
}


inputs = {
  create        = true

  clb_id = "lb-ponxxxxo"
  redirections = {
    "8081_to_8080" = {
      target_listener_id      = "lbl-knfxxxxq"
      target_rule_id          = "loc-1coxxxxo"  # domain abc.com, uri /aaa
      source_listener_id      = "lbl-8l1xxxx4"
      source_rule_id          = "loc-l5yxxxxu"  # domain def.com, uri /bbb
    },
    another = {
      target_listener_id      = "lbl-knfxxxxq"
      target_rule_id          = "loc-qjaxxxxg"  # domain abc.com, uri /aaaa
      source_listener_id      = "lbl-8l1xxxx4"
      source_rule_id          = "loc-fsuxxxxs"  # domain def.com, uri /bbbb
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
| [tencentcloud_clb_redirection.clb_redirection](https://registry.terraform.io/providers/tencentcloudstack/tencentcloud/latest/docs/resources/clb_redirection) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_clb_id"></a> [clb\_id](#input\_clb\_id) | load balancer id | `string` | n/a | yes |
| <a name="input_create"></a> [create](#input\_create) | create or not | `bool` | `true` | no |
| <a name="input_redirections"></a> [redirections](#input\_redirections) | see `tencentcloud_clb_redirection` | `any` | `{}` | no |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `"ap-jakarta"` | no |

## Outputs

No outputs.
