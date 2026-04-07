terraform {
  source = "../../sources/redirection"
}


inputs = {
  create        = true

  clb_id = "lb-ponxxxxo"
  redirections = {
    "8081_to_8080" = {
      target_listener_id      = "lbl-knfxxxxq"
      target_rule_id          = "loc-1coxxxxo"  # domain abc.com, uri /aaa
      source_listener_id      = "lbl-8l1xxxx4"
      source_rule_id          = "loc-l5yxxxxu"  # domain def.com, uri /bbb
    },
    another = {
      target_listener_id      = "lbl-knfxxxxq"
      target_rule_id          = "loc-qjaxxxxg"  # domain abc.com, uri /aaaa
      source_listener_id      = "lbl-8l1xxxx4"
      source_rule_id          = "loc-fsuxxxxs"  # domain def.com, uri /bbbb
    }
  }
}