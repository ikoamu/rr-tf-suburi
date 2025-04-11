resource "aws_dynamodb_table" "todo" {
  name           = "ikoamu_suburi_todo"
  hash_key       = "userId"
  range_key      = "timestamp"
  write_capacity = 1
  read_capacity  = 1

  attribute {
    name = "userId"
    type = "S"
  }

  attribute {
    name = "timestamp"
    type = "S"
  }
}
