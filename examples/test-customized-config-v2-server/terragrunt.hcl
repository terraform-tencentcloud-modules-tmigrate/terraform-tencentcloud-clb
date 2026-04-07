terraform {
  source = "../.."
}

inputs = {

  create = true
  config_name = "cros-server"
  config_content = <<EOT
add_header Access-Control-Allow-Methods 'POST, OPTIONS';
add_header Access-Control-Allow-Origin *;
EOT
  config_type = "SERVER"
  bind_list = [
    {
      load_balancer_id = "lb-czehdezt" # "lb-g1miv1ok"
      listener_id      = "lbl-gs9miu2v" # "lbl-9bsa90io"
      domain           = "www.qq.com" # "demo1.com"

    },
    {
      load_balancer_id = "lb-flvn7757" # "lb-g1miv1ok"
      listener_id      = "lbl-422eg97z" # "lbl-9bsa90io"
      domain           = "efg.com" # "demo1.com"
    }
  ]
}