variable "stage_name" {
  type = string
}

variable "database_name" {
  type = string
}

variable "schema_name" {
  type = string
}

variable "container_name" {
  type = string
}

variable "account_name" {
  type = string
}

variable "folder_name" {
  type = string
}

variable "storage_account_name" {
  type = string
}

variable "sas_token" {
  type = string
}

variable "table_name" {
  type = string
}

variable "column_names" {
  type = list(string)
}

variable "column_types" {
  type = list(string)
}

variable "pipe_name" {
  type = string
}

variable "pipe_definition" {
  type = string
}
