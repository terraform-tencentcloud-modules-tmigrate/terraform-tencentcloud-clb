# tencentcloud_clb_instance Public network CLB

Provides a resource to create an Public network CLB instance. more

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

  name          = "test-public-instance"
  create        = true
  clb =  {
    internet_bandwidth_max_out = 100
    internet_charge_type = "TRAFFIC_POSTPAID_BY_HOUR"
    dynamic_vip  = true

    vpc_id = "vpc-j0sqtqk7"
    sg_ids = ["sg-3fj6w1au"]

    master_zone_id = "ap-singapore-1"
    slave_zone_id = "ap-singapore-4"
  }

}

```


### to use bandwidth package

> set internet_charge_type = "BANDWIDTH_PACKAGE"

```hcl
terraform {
  source = "../.."
}

inputs = {

  name          = "test-public-with-bwp"
  create        = true
  clb =  {
    internet_bandwidth_max_out = 100
    internet_charge_type = "BANDWIDTH_PACKAGE"
    bandwidth_package_id = "bwp-hf4zo1sy"
    dynamic_vip  = true

    vpc_id = "vpc-j0sqtqk7"
    sg_ids = ["sg-3fj6w1au"]

    master_zone_id = "ap-singapore-1"
    slave_zone_id = "ap-singapore-4"
  }

}


```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12 |
| <a name="requirement_tencentcloud"></a> [tencentcloud](#requirement\_tencentcloud) | >1.78.1 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_clb"></a> [clb](#module\_clb) | git::https://github.com/terraform-tencentcloud-modules/terraform-tencentcloud-clb.git | master |

## Resources

No resources.

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
