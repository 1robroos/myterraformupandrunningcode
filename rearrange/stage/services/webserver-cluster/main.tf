provider "aws" {
  region = "us-east-1"
}
resource "aws_instance" "example" {
  ami                    = "ami-40d28157"
  instance_type          = "t2.micro"
  vpc_security_group_ids = ["${aws_security_group.instance.id}"]

  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, World" > index.html
              echo "${data.terraform_remote_state.db.address}" >> index.html
              echo "${data.terraform_remote_state.db.port}" >> index.html
              nohup busybox httpd -f -p "${var.server_port}" &
              EOF

  tags {
    Name = "terraform-example_withuserdata"
  }
}

resource "aws_security_group" "instance" {
  name = "terraform-example-instance"

  ingress {
    from_port   = "${var.server_port}"
    to_port     = "${var.server_port}"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


output "public_ip" {
  value = "${aws_instance.example.public_ip}"
}

terraform {
 backend "s3" {
   bucket = "kfsolutions-terraform-up-and-running-state"
   key    = "stage/services/webserver-cluster/terraform.tfstate"
   region = "us-east-1"

  }
}

data "terraform_remote_state" "db" {
  backend = "s3"

  config {
    bucket = "kfsolutions-terraform-up-and-running-state"
    key    = "stage/data-stores/mysql/terraform.tfstate"
    region = "us-east-1"
  }
}
