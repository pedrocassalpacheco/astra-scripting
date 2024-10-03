# Define external variables for token, orgID, database name, and keyspace name
variable "astradb_token" {
  description = "Your AstraDB token"
  type        = string
}

variable "astradb_org_id" {
  description = "Your AstraDB organization ID"
  type        = string
}

variable "database_name" {
  description = "Name of the database to create"
  type        = string
  default     = "db1" # Default value, can be overridden
}

variable "keyspace_name" {
  description = "Name of the keyspace to create"
  type        = string
  default     = "kp1" # Default value, can be overridden
}

variable "database_regions" {
  description = "List of database regions"
  type        = list(any)
  default     = ["us-east1"]
}

variable "cloud_provider" {
  description = "Name of the database to create"
  type        = string
  default     = "gcp"
}
