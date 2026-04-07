terraform {
  source = "../../modules/l7-listener-rule"
}


inputs = {
  create        = true

  clb_id = "lb-10qxxxxo"
  clb_listeners = {
    listener_1 = {
      listener_name = "http_listener"
      protocol = "HTTP"
      port = 80
      snat_enable = null
      default_domain = "80.801.net"
      keepalive_enable = 1 # Whether to enable a persistent connection. This parameter is applicable only to HTTP and HTTPS listeners. Valid values: 0 (disable; default value) and 1 (enable).
#      h2c_switch = true # Enable H2C switch for intranet HTTP listener.
      rules = {
        "80.801.net" = {
          #          domain         = "80.foo.net"
          domains                    = ["80.801.net", "80.802.net"]
          url                        = "/80-foo-edit"
          health_check_switch        = true
          health_check_interval_time = 5
          health_check_health_num    = 3
          health_check_unhealth_num  = 3
          health_check_time_out      = 3
          health_check_http_code     = 2
          health_check_http_path     = "/80-foo"
          health_check_http_domain   = "80.foo.net"
          health_check_http_method   = "GET"
        },
        "80.bar.net" = {
          domain              = "80.bar.net"
          url                 = "/80-bar"
          health_check_switch = false
        },
      }
    } ,
    listener_2 = {
      listener_name = "http_listener_8080"
      protocol = "HTTPS"
#      certificate_id = "JQxxxxxs"
#      certificate_ssl_mode = "UNIDIRECTIONAL"
      snat_enable = null
      port = 8080
      default_domain = "default.foo.net"
#      multi_cert_info = {
#        ssl_mode = "UNIDIRECTIONAL" # "UNIDIRECTIONAL"
#        cert_id_list = [
#          "KRBgxxxx", # RSA ssl certification
#          "LCYixxxx"  # ECC ssl certification
#        ]
#      }
      sni_switch = true
      rules = {
        "8080.foo.net" = {
#          domain         = "8080.foo.net"
          domains = ["8080.foo.net", "8080.foo1.net"]
          url            = "/8080-foo"
          health_check_switch        = true
          health_check_http_domain   = "8080.foo.net"
#          certificate_id = "KRBg83PP"
#          certificate_ssl_mode = "UNIDIRECTIONAL"
          multi_cert_info = {
            ssl_mode = "UNIDIRECTIONAL" # "UNIDIRECTIONAL"
            cert_id_list = [
              "KRBgxxxx", # RSA ssl certification
              "LCYixxxx"  # ECC ssl certification
            ]
          }
        },
        "default.foo.net" = {
#          domain         = "default.foo.net"
          domains = ["8080.foo.net", "8080.foo1.net"]
          url            = "/8080-foo-1"
          certificate_id = "KRBgxxxx"
          certificate_ssl_mode = "UNIDIRECTIONAL"
        }
      }
    }
  }
}