resource "aws_dynamodb_table" "app_data" {
  name         = "irsa-demo-table"
  billing_mode = "PAY_PER_REQUEST"

  hash_key = "id"

  attribute {
    name = "id"
    type = "S"
  }
}