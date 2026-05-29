output "storage_account_id" {
  description = "The resource ID of the storage account."
  value       = azurerm_storage_account.this.id
}

output "storage_account_name" {
  description = "The name of the storage account."
  value       = azurerm_storage_account.this.name
}

output "primary_blob_endpoint" {
  description = "The primary blob service endpoint URL."
  value       = azurerm_storage_account.this.primary_blob_endpoint
}

output "primary_access_key" {
  description = "The primary access key. Marked sensitive — use only when needed."
  value       = azurerm_storage_account.this.primary_access_key
  sensitive   = true
}

output "primary_connection_string" {
  description = "The primary connection string. Marked sensitive."
  value       = azurerm_storage_account.this.primary_connection_string
  sensitive   = true
}

output "container_ids" {
  description = "Map of container name to container resource ID."
  value       = { for k, v in azurerm_storage_container.this : k => v.id }
}
