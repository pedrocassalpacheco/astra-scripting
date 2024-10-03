# Specify the required providers and their versions
terraform {
  required_providers {
    astra = {
      source  = "datastax/astra"
      version = "2.3.7"
    }
  }
}

# Provider configuration
provider "astra" {
  token = var.astradb_token # Use the externalized token variable
}

data "astra_available_regions" "serverless_regions" {
}

output "available_regions" {
  value = [for region in data.astra_available_regions.serverless_regions.results : region.region]
}

data "astra_databases" "databaselist" {
  status = "ACTIVE"
}

output "existing_dbs" {
  value = [for db in data.astra_databases.databaselist.results : db.name]
}

data "astra_keyspaces" "keyspaces" {
  database_id = var.database_id
}

output "list_keyspaces" {
  value = [for name in data.astra_keyspaces.keyspaces.results : name]
}

data "astra_users" "devs" {
}

output "list_devs" {
  value = [for usr in data.astra_users.devs.users : usr]
}
