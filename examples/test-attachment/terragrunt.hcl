terraform {
  source = "../../sources/attachments"
}


inputs = {
  create        = true

  clb_id = "lb-3ykxxxxa"
  listener_id = "lbl-pbnxxxx8"
  rule_id = "loc-4q6xxxx4"
  targets = {
    target1 = {
      eni_ip = "10.6.8.250"
#      instance_id = "lb-brjxxxx8"
      port = 80
      weight = 100
    }
#    target3 = {
#      eni_ip = "10.0.1.6"
#      port = 80
#    }
#    target2 = {
#      eni_ip = "10.0.1.5"
#      port = 80
#    }
  }
}