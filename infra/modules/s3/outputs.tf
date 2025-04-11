output "archive_bucket" {
  value = aws_s3_object.zip.bucket
}

output "archive_bucket_key" {
  value = aws_s3_object.zip.key
}

output "archive_source_code_hash" {
  value = data.archive_file.ikoamu_suburi.output_base64sha256
}
