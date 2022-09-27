data "aws_subnet" "target_subnet" {
  filter {
    name = "tag:Name"
    values = ["tf-knowledge-share-vpc-${var.target_subnet}-${var.region}${var.az}"]
 }
}

data "aws_vpc" "main_vpc" {
filter {
    name   = "tag:Name"
    values = ["tf-knowledge-share-vpc"]
  }
}

resource "aws_network_interface" "eth1" {
  subnet_id   = data.aws_subnet.target_subnet.id
  tags = {
    Name = "primary_network_interface"
  }
}

resource "aws_instance" "instance" {
  ami           = var.ami
  instance_type = coalesce(var.instance_type, var.instance_type_conditional[lower(var.env)])

  network_interface {
    network_interface_id = aws_network_interface.eth1.id
    device_index         = 0
  }

  root_block_device {
    volume_size = var.vol_size
    volume_type = var.vol_type == null ? var.vol_type_conditional[lower(var.env)] : var.vol_type
  }

user_data = templatefile("${path.module}/${var.user_data}", { "name" = "test"})
tags = merge({Name = var.name},var.ec2_tags)

}

output "instance_id" {
  description = "ID of instance"
  value       = aws_instance.instance.id
}
