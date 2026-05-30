variable "resource_group_name" {
  description = "Name of the Azure Resource Group where the storage account will be created."
  type        = string
}

variable "location" {
  description = "Azure region for the storage account. Example: eastus, westeurope."
  type        = string
}

variable "storage_account_name" {
  description = "Name of the storage account. Must be globally unique, 3-24 chars, lowercase alphanumeric only."
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9]{3,24}$", var.storage_account_name))
    error_message = "Storage account name must be 3-24 lowercase alphanumeric characters."
  }
}

variable "account_tier" {
  description = "Performance tier. Standard (HDD) or Premium (SSD)."
  type        = string
  default     = "Standard"

  validation {
    condition     = contains(["Standard", "Premium"], var.account_tier)
    error_message = "account_tier must be Standard or Premium."
  }
}

variable "account_replication_type" {
  description = "Replication strategy. LRS, ZRS, GRS, or RAGRS."
  type        = string
  default     = "LRS"

  validation {
    condition     = contains(["LRS", "ZRS", "GRS", "RAGRS"], var.account_replication_type)
    error_message = "Must be LRS, ZRS, GRS, or RAGRS."
  }
}

variable "account_kind" {
  description = "Storage account kind. StorageV2 is recommended for most use cases."
  type        = string
  default     = "StorageV2"

  validation {
    condition     = contains(["StorageV2", "BlobStorage", "FileStorage"], var.account_kind)
    error_message = "Must be StorageV2, BlobStorage, or FileStorage."
  }
}

variable "enable_https_traffic_only" {
  description = "Force HTTPS only traffic. Always true in production."
  type        = bool
  default     = true
}

variable "min_tls_version" {
  description = "Minimum TLS version. TLS1_2 required in production."
  type        = string
  default     = "TLS1_2"
}

variable "enable_blob_versioning" {
  description = "Enable blob versioning for point-in-time recovery."
  type        = bool
  default     = false
}

variable "enable_soft_delete" {
  description = "Enable blob soft delete for accidental deletion recovery."
  type        = bool
  default     = true
}

variable "soft_delete_retention_days" {
  description = "Days to retain soft-deleted blobs. Only used if enable_soft_delete is true."
  type        = number
  default     = 7

  validation {
    condition     = var.soft_delete_retention_days >= 1 && var.soft_delete_retention_days <= 365
    error_message = "Retention days must be between 1 and 365."
  }
}

variable "containers" {
  description = "Map of blob containers to create. Key = container name, value = access type (private, blob, container)."
  type        = map(string)
  default     = {}

  # Example:
  # containers = {
  #   "raw-data"    = "private"
  #   "public-assets" = "blob"
  # }
}

variable "network_rules_default_action" {
  description = "Default network rule action. Deny recommended in production."
  type        = string
  default     = "Allow"   # Allow for dev ease; switch to Deny in prod

  validation {
    condition     = contains(["Allow", "Deny"], var.network_rules_default_action)
    error_message = "Must be Allow or Deny."
  }
}

variable "allowed_ip_ranges" {
  description = "List of public IP ranges allowed through the storage firewall."
  type        = list(string)
  default     = []
}

variable "allowed_subnet_ids" {
  description = "List of subnet resource IDs allowed through the storage firewall."
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "Map of tags to apply to the storage account."
  type        = map(string)
  default     = {}
}

variable "instance_count" {
  description = "Number of storage accounts to create."
  type        = number
  default     = 1

  validation {
    condition     = var.instance_count >= 1 && var.instance_count <= 5
    error_message = "instance_count must be between 1 and 5."
  }
}
