# Specify the required providers and their versions
terraform {
  required_providers {
    astra = {
      source  = "datastax/astra"
      version = "2.3.6"
    }
  }
}

# Provider configuration
provider "astra" {
  token = var.astradb_token # Use the externalized token variable
}

# Create a new AstraDB database
resource "astra_database" "db" {
  # Variables from tfvars files
  name           = var.database_name    # Database name
  keyspace       = var.keyspace_name    # Use the externalized keyspace name variable
  cloud_provider = var.cloud_provider   # Specify the cloud provider
  regions        = var.database_regions # Specify the region
}

# Output the database ID and keyspace name for reference
output "database_id" {
  value = astra_database.db.id
}

output "keyspace_name" {
  value = astra_database.db.keyspace
}
