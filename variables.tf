variable "vol_size" {
  default = null
}

variable "vol_type" {
  default = null
}

variable "ec2_tags" {
  type = map(any)
  default = {
    "Name" = "ec2-module"
  }
}

variable "instance_type" {
  default = null
}

variable "ami" {
  default = "ami-05fa00d4c63e32376"
}

variable "name" {
  
}

variable "user_data" {
  default = "userdata.sh.tpl"
}

variable "env" {
  default = null
}

variable "instance_type_conditional" {
  type = map
  default = {
    dev = "t2.micro"
    prod = "t2.large"
  }
}

variable "vol_type_conditional" {
  type = map
  default = {
    dev = "gp2"
    prod = "gp3"
  }
}

variable "target_subnet" {
  description = "Subnet to deploy EC2 values acceptable are"
  default = null
}

variable "region" {
  default = null
}

variable "az" {
  default = "a"
}