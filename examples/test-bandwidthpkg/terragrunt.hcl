terraform {
  source = "../../modules/public-instance"
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