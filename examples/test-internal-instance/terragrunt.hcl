terraform {
  source = "../.."
}

inputs = {

  name          = "test-internal-instance-1"
  create        = true
  clb =  {
    vpc_id = "vpc-j4zdb925"
    subnet_id   = "subnet-qadblhrc"
    sg_ids = ["sg-3fj6w1au"]
    vip = "10.0.0.251"
    sla_type = "clb.c2.medium"
    snat_pro = true
#    snat_ips = [
#      {
#        subnet_id = "subnet-qadblhrc"
#        ip        = "10.0.0.250"
#      }
#    ]
  }
}