resource "aws_s3_bucket" "tfstate" {
  bucket = "devops-remote-tfstate"

  tags = {
    Name        = "devops-remote-tfstate"
    Environment = "Dev"
  }
}