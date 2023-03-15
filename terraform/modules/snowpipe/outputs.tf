output "stage_fully_qualified_name" {
  value = snowflake_stage.example_stage.fully_qualified_name
}

output "table_fully_qualified_name" {
  value = snowflake_table.example_table.fully_qualified_name
}

output "pipe_fully_qualified_name" {
  value = snowflake_pipe.example_pipe.fully_qualified_name
}
