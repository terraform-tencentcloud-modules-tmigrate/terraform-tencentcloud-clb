# tencentcloud_clb_instance Private network CLB

Provides a resource to create an Private network CLB instance. more

Reference: https://registry.terraform.io/providers/tencentcloudstack/tencentcloud/latest/docs/resources/clb_instance


# CLB
Reference:

https://www.tencentcloud.com/document/product/214

https://www.tencentcloud.com/document/product/214/13629?lang=en&pg=


## usage

```hcl

terraform {
  source = "../.."
}

inputs = {

  name          = "test-internal-instance"
  create        = true
  clb =  {
    vpc_id = "vpc-j4zxxxx5"
    subnet_id   = "subnet-qadxxxxc"
    sg_ids = ["sg-3fjxxxxu"]
    vip = "10.0.0.251" # specify an internal IP address. It will be auto allocated when omitted
    sla_type = "clb.c3.small" # This parameter is required to create LCU-supported instances. Values:SLA: Super Large 4. When you have activated Super Large models, SLA refers to Super Large 4; clb.c2.medium: Standard; clb.c3.small: Advanced 1; clb.c3.medium: Advanced 1; clb.c4.small: Super Large 1; clb.c4.medium: Super Large 2; clb.c4.large: Super Large 3; clb.c4.xlarge: Super Large 4. For more details, see https://www.tencentcloud.com/document/product/214/54820?has_map=1&lang=en&pg=.
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

| Name | Source | Version |
|------|--------|---------|
| <a name="module_clb"></a> [clb](#module\_clb) | git::https://github.com/terraform-tencentcloud-modules/terraform-tencentcloud-clb.git | master |

## Resources

| Name | Type |
|------|------|
| [tencentcloud_clb_snat_ip.foo](https://registry.terraform.io/providers/tencentcloudstack/tencentcloud/latest/docs/resources/clb_snat_ip) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_clb"></a> [clb](#input\_clb) | see clb module | `any` | `{}` | no |
| <a name="input_create"></a> [create](#input\_create) | create or not | `bool` | `true` | no |
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | `""` | no |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `"ap-jakarta"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_clb_id"></a> [clb\_id](#output\_clb\_id) | clb id |
| <a name="output_clb_name"></a> [clb\_name](#output\_clb\_name) | n/a |
| <a name="output_clb_vips"></a> [clb\_vips](#output\_clb\_vips) | n/a |
