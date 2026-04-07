terraform {
  source = "../../modules/public-instance"
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