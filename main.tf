resource "aws_networkfirewall_firewall_policy" "networkfirewall_firewall_policies" {
  for_each = var.networkfirewall_firewall_policies

  name        = each.value.name
  description = each.value.description
  region      = each.value.region
  tags        = each.value.tags
  tags_all    = each.value.tags_all

  firewall_policy {
    enable_tls_session_holding = each.value.firewall_policy.enable_tls_session_holding
    dynamic "policy_variables" {
      for_each = each.value.firewall_policy.policy_variables != null ? [each.value.firewall_policy.policy_variables] : []
      content {
        dynamic "rule_variables" {
          for_each = policy_variables.value.rule_variables != null ? policy_variables.value.rule_variables : []
          content {
            ip_set {
              definition = rule_variables.value.ip_set.definition
            }
            key = rule_variables.value.key
          }
        }
      }
    }
    stateful_default_actions = each.value.firewall_policy.stateful_default_actions
    dynamic "stateful_engine_options" {
      for_each = each.value.firewall_policy.stateful_engine_options != null ? [each.value.firewall_policy.stateful_engine_options] : []
      content {
        dynamic "flow_timeouts" {
          for_each = stateful_engine_options.value.flow_timeouts != null ? [stateful_engine_options.value.flow_timeouts] : []
          content {
            tcp_idle_timeout_seconds = flow_timeouts.value.tcp_idle_timeout_seconds
          }
        }
        rule_order              = stateful_engine_options.value.rule_order
        stream_exception_policy = stateful_engine_options.value.stream_exception_policy
      }
    }
    dynamic "stateful_rule_group_reference" {
      for_each = each.value.firewall_policy.stateful_rule_group_reference != null ? each.value.firewall_policy.stateful_rule_group_reference : []
      content {
        deep_threat_inspection = stateful_rule_group_reference.value.deep_threat_inspection
        dynamic "override" {
          for_each = stateful_rule_group_reference.value.override != null ? [stateful_rule_group_reference.value.override] : []
          content {
            action = override.value.action
          }
        }
        priority     = stateful_rule_group_reference.value.priority
        resource_arn = stateful_rule_group_reference.value.resource_arn
      }
    }
    dynamic "stateless_custom_action" {
      for_each = each.value.firewall_policy.stateless_custom_action != null ? each.value.firewall_policy.stateless_custom_action : []
      content {
        action_definition {
          publish_metric_action {
            dynamic "dimension" {
              for_each = stateless_custom_action.value.action_definition.publish_metric_action.dimension
              content {
                value = dimension.value.value
              }
            }
          }
        }
        action_name = stateless_custom_action.value.action_name
      }
    }
    stateless_default_actions          = each.value.firewall_policy.stateless_default_actions
    stateless_fragment_default_actions = each.value.firewall_policy.stateless_fragment_default_actions
    dynamic "stateless_rule_group_reference" {
      for_each = each.value.firewall_policy.stateless_rule_group_reference != null ? each.value.firewall_policy.stateless_rule_group_reference : []
      content {
        priority     = stateless_rule_group_reference.value.priority
        resource_arn = stateless_rule_group_reference.value.resource_arn
      }
    }
    tls_inspection_configuration_arn = each.value.firewall_policy.tls_inspection_configuration_arn
  }

  dynamic "encryption_configuration" {
    for_each = each.value.encryption_configuration != null ? [each.value.encryption_configuration] : []
    content {
      key_id = encryption_configuration.value.key_id
      type   = encryption_configuration.value.type
    }
  }
}

