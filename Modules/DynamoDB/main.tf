resource "aws_dynamodb_table" "lighting_table" {
  count          = length(var.table_names)
  name           = var.table_names[count.index]
  billing_mode   = "PROVISIONED"
  read_capacity  = 20
  write_capacity = 20
  hash_key       = "id"
  attribute {
    name = "id"
    type = "N"
  }
  tags = {
    Name        = format(element(var.table_tags, count.index + 1))
    Environment = "production"
  }
}
