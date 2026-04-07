terraform {
  source = "../.."
}


inputs = {
  create        = true

  clb_id = "lb-pon28uyo"
  clb_listeners = {
    listener_1 = {
      listener_name = "http_listener"
      protocol = "HTTP"
      port = 8888
      default_domain = "80.801.net"
      snat_enable = null
      keepalive_enable = 1 # Whether to enable a persistent connection. This parameter is applicable only to HTTP and HTTPS listeners. Valid values: 0 (disable; default value) and 1 (enable).
#      h2c_switch = true # Enable H2C switch for intranet HTTP listener.
      rules = {
        "80.801.net" = {
#          domain         = "80.foo.net"
          domains         = ["80.801.net", "80.802.net", "80.803.net", "80.804.net"]
          url            = "/80-foo-edit"
          health_check_switch        = true
          health_check_interval_time = 5
          health_check_health_num    = 3
          health_check_unhealth_num  = 3
          health_check_time_out      = 3
          health_check_http_code     = 2
          health_check_http_path     = "/80-foo"
          health_check_http_domain   = "80.foo.net"
          health_check_http_method   = "GET"
#          health_check_type = "GRPC"
#          forward_type = "GRPC"
        },
        "80.bar.net" = {
#          domain         = "80.bar.net"
          domains        = ["80.801.net", "80.802.net", "80.803.net", "80.804.net"]
          url            = "/80-bar-dup"
          health_check_switch   = false
#          forward_type = "GRPC"
        },
        "dup" = {
          domains        = ["80.801.net", "80.802.net", "80.803.net", "80.804.net"]
          url            = "/80-bar"
          health_check_switch   = false
          #          forward_type = "GRPC"
        },
      }
    }
  }

}