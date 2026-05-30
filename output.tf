output "storage_account_ids" {
  description = "List of all created storage account IDs."
  value       = azurerm_storage_account.this[*].id
  # [*] = splat expression, gives you all values as a list
}

output "storage_account_names" {
  description = "List of all created storage account names."
  value       = azurerm_storage_account.this[*].name
}

output "primary_blob_endpoints" {
  description = "List of all primary blob endpoints."
  value       = azurerm_storage_account.this[*].primary_blob_endpoint
}
