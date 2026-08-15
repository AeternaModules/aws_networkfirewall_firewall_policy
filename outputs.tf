output "networkfirewall_firewall_policies_id" {
  description = "Map of id values across all networkfirewall_firewall_policies, keyed the same as var.networkfirewall_firewall_policies"
  value       = { for k, v in aws_networkfirewall_firewall_policy.networkfirewall_firewall_policies : k => v.id if v.id != null && length(v.id) > 0 }
}
output "networkfirewall_firewall_policies_arn" {
  description = "Map of arn values across all networkfirewall_firewall_policies, keyed the same as var.networkfirewall_firewall_policies"
  value       = { for k, v in aws_networkfirewall_firewall_policy.networkfirewall_firewall_policies : k => v.arn if v.arn != null && length(v.arn) > 0 }
}
output "networkfirewall_firewall_policies_description" {
  description = "Map of description values across all networkfirewall_firewall_policies, keyed the same as var.networkfirewall_firewall_policies"
  value       = { for k, v in aws_networkfirewall_firewall_policy.networkfirewall_firewall_policies : k => v.description if v.description != null && length(v.description) > 0 }
}
output "networkfirewall_firewall_policies_encryption_configuration" {
  description = "Map of encryption_configuration values across all networkfirewall_firewall_policies, keyed the same as var.networkfirewall_firewall_policies"
  value       = { for k, v in aws_networkfirewall_firewall_policy.networkfirewall_firewall_policies : k => one(v.encryption_configuration) if v.encryption_configuration != null && length(v.encryption_configuration) > 0 }
}
output "networkfirewall_firewall_policies_firewall_policy" {
  description = "Map of firewall_policy values across all networkfirewall_firewall_policies, keyed the same as var.networkfirewall_firewall_policies"
  value       = { for k, v in aws_networkfirewall_firewall_policy.networkfirewall_firewall_policies : k => one(v.firewall_policy) if v.firewall_policy != null && length(v.firewall_policy) > 0 }
}
output "networkfirewall_firewall_policies_name" {
  description = "Map of name values across all networkfirewall_firewall_policies, keyed the same as var.networkfirewall_firewall_policies"
  value       = { for k, v in aws_networkfirewall_firewall_policy.networkfirewall_firewall_policies : k => v.name if v.name != null && length(v.name) > 0 }
}
output "networkfirewall_firewall_policies_region" {
  description = "Map of region values across all networkfirewall_firewall_policies, keyed the same as var.networkfirewall_firewall_policies"
  value       = { for k, v in aws_networkfirewall_firewall_policy.networkfirewall_firewall_policies : k => v.region if v.region != null && length(v.region) > 0 }
}
output "networkfirewall_firewall_policies_tags" {
  description = "Map of tags values across all networkfirewall_firewall_policies, keyed the same as var.networkfirewall_firewall_policies"
  value       = { for k, v in aws_networkfirewall_firewall_policy.networkfirewall_firewall_policies : k => v.tags if v.tags != null && length(v.tags) > 0 }
}
output "networkfirewall_firewall_policies_tags_all" {
  description = "Map of tags_all values across all networkfirewall_firewall_policies, keyed the same as var.networkfirewall_firewall_policies"
  value       = { for k, v in aws_networkfirewall_firewall_policy.networkfirewall_firewall_policies : k => v.tags_all if v.tags_all != null && length(v.tags_all) > 0 }
}
output "networkfirewall_firewall_policies_update_token" {
  description = "Map of update_token values across all networkfirewall_firewall_policies, keyed the same as var.networkfirewall_firewall_policies"
  value       = { for k, v in aws_networkfirewall_firewall_policy.networkfirewall_firewall_policies : k => v.update_token if v.update_token != null && length(v.update_token) > 0 }
}

