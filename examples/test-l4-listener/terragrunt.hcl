terraform {
  source = "../../modules/l4-listener"
}


inputs = {
  create        = true

  clb_id = "lb-10qyuj6o"
  clb_listeners = {
    listener_1 = {
      listener_name = "tcp_listener_8888"

      health_check_switch        = true
      health_check_time_out      = 2
      health_check_interval_time = 5
      health_check_health_num    = 3
      health_check_unhealth_num  = 3
      health_check_port          = 200
      health_check_type          = "HTTP"
      health_check_http_code     = 2
      health_check_http_version  = "HTTP/1.0"
      health_check_http_method   = "GET"

      protocol            = "TCP"
      port                = 8888
      session_expire_time = 30
      scheduler           = "WRR"
      session_expire_time = 30
      // set this value to allow a target group to attach
      #      target_type = "TARGETGROUP" # NODE, TARGETGROUP. NODE means to bind ordinary nodes, TARGETGROUP means to bind target group.
    },
    listener_2 = {
      listener_name = "tcp_listener_9999"
      protocol      = "TCP"

      health_check_switch = false

      port                = 9999
      session_expire_time = 60
      snat_enable = true # default false
    }
  }
}