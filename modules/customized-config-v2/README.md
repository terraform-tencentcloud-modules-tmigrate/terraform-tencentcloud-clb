# tencentcloud clb customized config V2

Provides a resource to create an clb customized config V2. more

Reference: https://cloud.tencent.com/document/api/214/60008



## usage

create SERVER type config

```hcl

terraform {
  source = "../.."
}

inputs = {

  create = true
  config_name = "cros-server"
  config_content = <<EOT
add_header Access-Control-Allow-Methods 'POST, OPTIONS';
add_header Access-Control-Allow-Origin *;
EOT
  config_type = "SERVER"
  bind_list = [
    {
      load_balancer_id = "lb-czehdezt" # "lb-g1miv1ok"
      listener_id      = "lbl-gs9miu2v" # "lbl-9bsa90io"
      domain           = "www.qq.com" # "demo1.com"

    },
    {
      load_balancer_id = "lb-flvn7757" # "lb-g1miv1ok"
      listener_id      = "lbl-422eg97z" # "lbl-9bsa90io"
      domain           = "efg.com" # "demo1.com"
    }
  ]
}

```

create LOCATION type config

```hcl 
terraform {
  source = "../.."
}

inputs = {

  create = true
  config_name = "cros"
  config_content = <<EOT
add_header Access-Control-Allow-Methods 'POST, OPTIONS';
add_header Access-Control-Allow-Origin *;
EOT
  config_type = "LOCATION"
  bind_list = [
    {
      load_balancer_id = "lb-czehdezt" # "lb-g1miv1ok"
      listener_id      = "lbl-gs9miu2v" # "lbl-9bsa90io"
      location_id = "loc-kpvsgnsz"
      domain           = "www.qq.com" # "demo1.com"

    },
    {
      load_balancer_id = "lb-flvn7757" # "lb-g1miv1ok"
      listener_id      = "lbl-422eg97z" # "lbl-9bsa90io"
      location_id = "loc-2nzzemwx"
      domain           = "efg.com" # "demo1.com"
    }
  ]
}


```
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12 |
| <a name="requirement_tencentcloud"></a> [tencentcloud](#requirement\_tencentcloud) | >= 1.81.169 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_tencentcloud"></a> [tencentcloud](#provider\_tencentcloud) | >= 1.81.169 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [tencentcloud_clb_customized_config_attachment.attachments](https://registry.terraform.io/providers/tencentcloudstack/tencentcloud/latest/docs/resources/clb_customized_config_attachment) | resource |
| [tencentcloud_clb_customized_config_v2.config](https://registry.terraform.io/providers/tencentcloudstack/tencentcloud/latest/docs/resources/clb_customized_config_v2) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bind_list"></a> [bind\_list](#input\_bind\_list) | clb list to bind this config | `any` | `[]` | no |
| <a name="input_config_content"></a> [config\_content](#input\_config\_content) | Content of Customized Config. | `string` | `""` | no |
| <a name="input_config_name"></a> [config\_name](#input\_config\_name) | Name of Customized Config. | `string` | `""` | no |
| <a name="input_config_type"></a> [config\_type](#input\_config\_type) | Type of Customized Config. Valid values: SERVER and LOCATION | `string` | `""` | no |
| <a name="input_create"></a> [create](#input\_create) | create or not | `bool` | `true` | no |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `"ap-jakarta"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_clb_customized_config_v2_id"></a> [clb\_customized\_config\_v2\_id](#output\_clb\_customized\_config\_v2\_id) | n/a |
