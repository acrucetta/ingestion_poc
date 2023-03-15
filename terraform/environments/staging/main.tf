provider "snowflake" {
  account   = var.snowflake_account
  user      = var.snowflake_user
  password  = var.snowflake_password
  role      = var.snowflake_role
  warehouse = var.snowflake_warehouse
}

module "snowpipe_example1" {
  source = "./modules/snowpipe"

  stage_name            = "example_stage1"
  database_name         = var.snowflake_database
  schema_name           = var.snowflake_schema
  container_name        = var.azure_container1
  account_name          = var.azure_account
  folder_name           = var.azure_folder1
  storage_account_name  = var.azure_storage_account
  sas_token             = var.azure_sas_token
  table_name            = "example_table1"
  column_names          = ["id", "name"]
  column_types          = ["NUMBER", "VARCHAR(50)"]
  pipe_name             = "example_pipe1"
  pipe_definition       = <<-EOF
    COPY INTO ${snowflake_table.example_table1.fully_qualified_name}
    FROM ${snowflake_stage.example_stage1.name}
    FILE_FORMAT = ${snowflake_stage.example_stage1.file_format}
    PURGE = TRUE;
  EOF
}

module "snowpipe_example2" {
  source = "./modules/snowpipe"

  stage_name            = "example_stage2"
  database_name         = var.snowflake_database
  schema_name           = var.snowflake_schema
  container_name        = var.azure_container2
  account_name          = var.azure_account
  folder_name           = var.azure_folder2
  storage_account_name  = var.azure_storage_account
  sas_token             = var.azure_sas_token
  table_name            = "example_table2"
  column_names          = ["id", "name"]
  column_types          = ["NUMBER", "VARCHAR(50)"]
  pipe_name             = "example_pipe2"
  pipe_definition       = <<-EOF
    COPY INTO ${snowflake_table.example_table2.fully_qualified_name}
    FROM ${snowflake_stage.example_stage2.name}
    FILE_FORMAT = ${snowflake_stage.example_stage2.file_format}
    PURGE = TRUE;
  EOF
}

resource "snowflake_database" "example_db" {
  name       = var.snowflake_database
  comment    = "Example Snowflake database"
  owner      = var.snowflake_user
  managed    = true
  lifecycle {
    prevent_destroy = true
  }
}

resource "snowflake_schema" "example_schema" {
  name     = var.snowflake_schema
  database = snowflake_database.example_db.name
  comment  = "Example Snowflake schema"
}

output "stage_fully_qualified_name1" {
  value = module.snowpipe_example1.stage_fully_qualified_name
}

output "table_fully_qualified_name1" {
  value = module.snowpipe_example1.table_fully_qualified_name
}

output "pipe_fully_qualified_name1" {
  value = module.snowpipe_example1.pipe_fully_qualified_name
}

output "stage_fully_qualified_name2" {
  value = module.snowpipe_example2.stage_fully_qualified_name
}

output "table_fully_qualified_name2" {
  value = module.snowpipe_example2.table_fully_qualified_name
}

output "pipe_fully_qualified_name2" {
value = module.snowpipe_example2.pipe_fully_qualified_name
}