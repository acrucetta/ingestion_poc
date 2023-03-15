resource "snowflake_stage" "example_stage" {
  name     = var.stage_name
  database = var.database_name
  schema   = var.schema_name

  snowflake_iam_user = "awsuser"
  url               = "azure://${var.container_name}@${var.account_name}.blob.core.windows.net/${var.folder_name}/"
  credentials        {
    type     = "AZURE_SAS_TOKEN"
    username = var.storage_account_name
    password = var.sas_token
  }
  file_format       = "CSV"
}

resource "snowflake_pipe" "example_pipe" {
  name     = var.pipe_name
  database = var.database_name
  schema   = var.schema_name
  auto_ingest = true

  definition = var.pipe_definition
}

resource "snowflake_table" "example_table" {
  name     = var.table_name
  database = var.database_name
  schema   = var.schema_name

  dynamic "column" {
    for_each = var.column_names
    content {
      name = column.value
      type = var.column_types[index]
    }
  }
}
