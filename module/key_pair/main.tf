resource "tls_private_key" "key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "this" {
  key_name   = var.key_name
  public_key = tls_private_key.key.public_key_openssh
  tags       = var.tags
}

resource "aws_s3_object" "private_key" {
  bucket = var.bucket_name
  key    = "${var.key_name}.pem"
  content = tls_private_key.key.private_key_pem
  acl     = "private"
}
