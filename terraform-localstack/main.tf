# --- S3 bucket ---
resource "aws_s3_bucket" "demo" {
  bucket = "localstack-demo-bucket"
  tags = {
    Project = "LocalCloudLab"
  }
}


resource "aws_instance" "demo" {
  ami           = "ami-12345678" # любое значение, LocalStack не проверяет
  instance_type = "t3.micro"
  tags = {
    Name    = "LocalStack-Demo-EC2"
    Project = "LocalCloudLab"
  }
}
