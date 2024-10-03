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

# Create a new table
resource "astra_table" "fedex_table" {
  # Required
  keyspace           = var.keyspace_name
  database_id        = var.database_id
  region             = var.database_regions[0]
  table              = "a_table_of_data"
  clustering_columns = "a:b"
  partition_keys     = "c:d"
  column_definitions = [
    {
      Name : "a"
      Static : false
      TypeDefinition : "text"
    },
    {
      Name : "b"
      Static : false
      TypeDefinition : "text"
    },
    {
      Name : "c"
      Static : false
      TypeDefinition : "text"
    },
    {
      Name : "d"
      Static : false
      TypeDefinition : "text"
    },
    {
      Name : "e"
      Static : false
      TypeDefinition : "text"
    }, 
    {
      Name : "f"
      Static : false
      TypeDefinition : "text"
    }
  ]
}
