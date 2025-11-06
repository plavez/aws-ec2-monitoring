# --- S3 bucket ---
resource "aws_s3_bucket" "test_bucket" {
  bucket = "localstack-demo-bucket"
}

# --- EC2 mock (создастся запись, без реальной ВМ) ---
resource "aws_instance" "demo_instance" {
  ami           = "ami-12345678" # любое значение, LocalStack не проверяет
  instance_type = "t3.micro"
  tags = {
    Name = "LocalStack-Demo-EC2"
  }
}
