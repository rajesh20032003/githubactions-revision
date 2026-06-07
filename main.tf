resource "aws_instance" "web_server" {
  ami           = "ami-052cef05d01020f1d"
  instance_type = "t2.micro"
}