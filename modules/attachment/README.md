# tencentcloud clb attachment

Attach backend to clb

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
  create = true

  clb_id      = "lb-a83xxxxa"
  listener_id = "lbl-npxxxxxw"
#  rule_id     = "loc-r00xxxx8" # for http/https listener
  targets     = {
    target1 = {
      eni_ip = "10.0.1.16"  # for CLB attachment
      #      instance_id = "lb-brjxxxx8" # for CVM attachment
      port   = 80
    }
  }
}
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12 |
| <a name="requirement_tencentcloud"></a> [tencentcloud](#requirement\_tencentcloud) | >1.78.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_tencentcloud"></a> [tencentcloud](#provider\_tencentcloud) | >1.78.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [tencentcloud_clb_attachment.attachments](https://registry.terraform.io/providers/tencentcloudstack/tencentcloud/latest/docs/resources/clb_attachment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_clb_id"></a> [clb\_id](#input\_clb\_id) | load balancer id | `string` | `null` | no |
| <a name="input_create"></a> [create](#input\_create) | create or not | `bool` | `true` | no |
| <a name="input_domain"></a> [domain](#input\_domain) | Domain of the target forwarding rule. Does not take effect when parameter rule\_id is provided. | `string` | `null` | no |
| <a name="input_listener_id"></a> [listener\_id](#input\_listener\_id) | ID of the CLB listener. | `string` | `null` | no |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `"ap-jakarta"` | no |
| <a name="input_rule_id"></a> [rule\_id](#input\_rule\_id) | ID of the CLB listener rule. Only supports listeners of HTTPS and HTTP protocol. | `string` | `null` | no |
| <a name="input_targets"></a> [targets](#input\_targets) | target of clb, see `tencentcloud_clb_attachment` | `any` | `{}` | no |
| <a name="input_url"></a> [url](#input\_url) | URL of the target forwarding rule. Does not take effect when parameter rule\_id is provided. | `string` | `null` | no |

## Outputs

No outputs.
