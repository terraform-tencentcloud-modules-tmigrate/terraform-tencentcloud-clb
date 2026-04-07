module "clb" {
  source = "../../modules/public-instance"
  name          = "test-bwp-att"
  create        = true
  clb =  {
    internet_bandwidth_max_out = 100
#    internet_charge_type = "TRAFFIC_POSTPAID_BY_HOUR"
#    bandwidth_package_id = ""
    internet_charge_type = "BANDWIDTH_PACKAGE"
    bandwidth_package_id = "bwp-hf4xxxxy"
    dynamic_vip  = true

    vpc_id = "vpc-j0sqtqk7"
    sg_ids = ["sg-3fj6w1au"]

    master_zone_id = "ap-singapore-1"
    slave_zone_id = "ap-singapore-4"
  }
}

resource "tencentcloud_vpc_bandwidth_package_attachment" "attachment" {
  resource_id          = module.clb.clb_id
  bandwidth_package_id = "bwp-hf4xxxxy"
  network_type         = "BGP"
  resource_type        = "LoadBalance"
}