variable "networkfirewall_firewall_policies" {
  description = <<EOT
Map of networkfirewall_firewall_policies, attributes below
Required:
    - name
    - firewall_policy (block):
        - enable_tls_session_holding (optional)
        - policy_variables (optional, block):
            - rule_variables (optional, block):
                - ip_set (required, block):
                    - definition (required)
                - key (required)
        - stateful_default_actions (optional)
        - stateful_engine_options (optional, block):
            - flow_timeouts (optional, block):
                - tcp_idle_timeout_seconds (optional)
            - rule_order (optional)
            - stream_exception_policy (optional)
        - stateful_rule_group_reference (optional, block):
            - deep_threat_inspection (optional)
            - override (optional, block):
                - action (optional)
            - priority (optional)
            - resource_arn (required)
        - stateless_custom_action (optional, block):
            - action_definition (required, block):
                - publish_metric_action (required, block):
                    - dimension (required, block):
                        - value (required)
            - action_name (required)
        - stateless_default_actions (required)
        - stateless_fragment_default_actions (required)
        - stateless_rule_group_reference (optional, block):
            - priority (required)
            - resource_arn (required)
        - tls_inspection_configuration_arn (optional)
Optional:
    - description
    - region
    - tags
    - tags_all
    - encryption_configuration (block):
        - key_id (optional)
        - type (required)
EOT

  type = map(object({
    name        = string
    description = optional(string)
    region      = optional(string)
    tags        = optional(map(string))
    tags_all    = optional(map(string))
    firewall_policy = object({
      enable_tls_session_holding = optional(bool)
      policy_variables = optional(object({
        rule_variables = optional(list(object({
          ip_set = object({
            definition = set(string)
          })
          key = string
        })))
      }))
      stateful_default_actions = optional(set(string))
      stateful_engine_options = optional(object({
        flow_timeouts = optional(object({
          tcp_idle_timeout_seconds = optional(number)
        }))
        rule_order              = optional(string)
        stream_exception_policy = optional(string)
      }))
      stateful_rule_group_reference = optional(list(object({
        deep_threat_inspection = optional(string)
        override = optional(object({
          action = optional(string)
        }))
        priority     = optional(number)
        resource_arn = string
      })))
      stateless_custom_action = optional(list(object({
        action_definition = object({
          publish_metric_action = object({
            dimension = list(object({
              value = string
            }))
          })
        })
        action_name = string
      })))
      stateless_default_actions          = set(string)
      stateless_fragment_default_actions = set(string)
      stateless_rule_group_reference = optional(list(object({
        priority     = number
        resource_arn = string
      })))
      tls_inspection_configuration_arn = optional(string)
    })
    encryption_configuration = optional(object({
      key_id = optional(string)
      type   = string
    }))
  }))
  validation {
    condition = alltrue([
      for k, v in var.networkfirewall_firewall_policies : (
        v.firewall_policy.stateless_custom_action == null || alltrue([for item in v.firewall_policy.stateless_custom_action : (length(item.action_definition.publish_metric_action.dimension) >= 1)])
      )
    ])
    error_message = "Each dimension list must contain at least 1 items"
  }
  validation {
    condition = alltrue([
      for k, v in var.networkfirewall_firewall_policies : (
        v.firewall_policy.stateful_engine_options == null || (v.firewall_policy.stateful_engine_options.flow_timeouts == null || (v.firewall_policy.stateful_engine_options.flow_timeouts.tcp_idle_timeout_seconds == null || (v.firewall_policy.stateful_engine_options.flow_timeouts.tcp_idle_timeout_seconds >= 60 && v.firewall_policy.stateful_engine_options.flow_timeouts.tcp_idle_timeout_seconds <= 6000)))
      )
    ])
    error_message = "must be between 60 and 6000"
  }
  validation {
    condition = alltrue([
      for k, v in var.networkfirewall_firewall_policies : (
        v.firewall_policy.stateless_custom_action == null || alltrue([for item in v.firewall_policy.stateless_custom_action : (can(regex("^[0-9A-Za-z]+$", item.action_name)))])
      )
    ])
    error_message = "must contain only alphanumeric characters"
  }
  # Note: 11 additional provider-side validators are enforced at apply time but not mirrored as validation{} blocks here (bespoke or non-mechanically-translatable).
}

