resource "azurerm_storage_account" "this" {
  name                     = var.storage_account_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type
  account_kind             = var.account_kind

  enable_https_traffic_only = var.enable_https_traffic_only
  min_tls_version           = var.min_tls_version

  blob_properties {
    versioning_enabled = var.enable_blob_versioning

    dynamic "delete_retention_policy" {
      for_each = var.enable_soft_delete ? [1] : []
      content {
        days = var.soft_delete_retention_days
      }
    }
  }

  network_rules {
    default_action             = var.network_rules_default_action
    ip_rules                   = var.allowed_ip_ranges
    virtual_network_subnet_ids = var.allowed_subnet_ids
    bypass                     = ["AzureServices"]
    # AzureServices bypass: allows Azure Backup, Monitor, etc. to reach the account
  }

  tags = var.tags
}

resource "azurerm_storage_container" "this" {
  for_each = var.containers

  name                  = each.key
  storage_account_name  = azurerm_storage_account.this.name
  container_access_type = each.value
}
