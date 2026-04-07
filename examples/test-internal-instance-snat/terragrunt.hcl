terraform {
  source = "../.."
}

inputs = {

  name          = "test-snat20"
  create        = true
  clb =  {
    vpc_id = "vpc-827xxxxd"
    subnet_id   = "subnet-e72xxxxy"
    sg_ids = []
#    vip = "10.0.0.251"
#    sla_type = "clb.c2.medium"
    snat_pro = true
    snat_ips = [
      {
        subnet_id = "subnet-e72xxxxy"
        ip        = "10.4.10.250"
      }
    ]
  }
}