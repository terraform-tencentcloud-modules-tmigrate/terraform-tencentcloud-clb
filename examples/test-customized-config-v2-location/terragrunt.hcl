terraform {
  source = "../.."
}

inputs = {

  create = true
  config_name = "cros"
  config_content = <<EOT
if ($request_method ~ ^(GET|HEAD)$) {
    rewrite ^/(.*)$ /RESERVE_FOR_READ$1 last;
}
if ($request_method ~ ^(POST|PATCH|PUT|DELETE)$) {
    rewrite ^/(.*)$ /RESERVE_FOR_WRITE$1 last;
}
EOT
  config_type = "LOCATION"
  bind_list = [
    {
      load_balancer_id = "lb-czehdezt" # "lb-g1miv1ok"
      listener_id      = "lbl-gs9miu2v" # "lbl-9bsa90io"
      location_id = "loc-kpvsgnsz"
      domain           = "www.qq.com" # "demo1.com"

    },
    {
      load_balancer_id = "lb-flvn7757" # "lb-g1miv1ok"
      listener_id      = "lbl-422eg97z" # "lbl-9bsa90io"
      location_id = "loc-2nzzemwx"
      domain           = "efg.com" # "demo1.com"
    }
  ]
}