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

    vpc_id = "vpc-j0sxxxx7"
    sg_ids = ["sg-3fjxxxxu"]

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
    bandwidth_package_id = "bwp-hf4xxxxy"
    dynamic_vip  = true

    vpc_id = "vpc-j0sxxxx7"
    sg_ids = ["sg-3fjxxxxu"]

    master_zone_id = "ap-singapore-1"
    slave_zone_id = "ap-singapore-4"
  }

}


```

