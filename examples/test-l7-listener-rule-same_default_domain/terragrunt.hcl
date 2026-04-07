terraform {
  source = "../../modules/l7-listener-rule"
}


inputs = {
  create        = true

  clb_id = "lb-10qxxxxo"
  clb_listeners = {
    listener_8082 = {
      listener_name = "listener_8080"
      protocol = "HTTP"
      port = 8082
      default_domain = "8080.net"
      rules = {
        "8080.net" = {
          domains = ["8080.net", "8081.net"]
#          domain         = "8080.net"
          url            = "/"
          health_check_switch        = true
          health_check_interval_time = 5
          health_check_health_num    = 3
          health_check_unhealth_num  = 3
          health_check_port = 8888
          health_check_time_out      = 3
          health_check_http_code     = 2
          health_check_http_path     = "/"
          health_check_http_domain   = "80.foo.net"
          health_check_http_method   = "GET"
        },
        "8080.net/aaa" = {
          domains = ["8080.net", "8081.net"]
#          domain         = "8080.net"
          url            = "/aaa"
          health_check_switch        = true
          health_check_interval_time = 5
          health_check_health_num    = 3
          health_check_unhealth_num  = 3
          health_check_port = 8888
          health_check_time_out      = 3
          health_check_http_code     = 2
          health_check_http_path     = "/aaa"
          health_check_http_domain   = "80.foo.net"
          health_check_http_method   = "GET"
        },
      }
    } ,
    listener_8081 = {
      listener_name = "listener_8081"
      protocol = "HTTP"
      port = 8081
      default_domain = "8081.net"
      rules = {
        "8080.net" = {
          domain         = "8081.net"
          url            = "/"
          health_check_switch = false
        },
      }
    }
  }
}