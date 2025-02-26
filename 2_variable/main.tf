provider "aws" {
    region="ap-south-1"  
}

# resource "aws_instance" "first" {
# ami = var.ubuntu_ami
# instance_type = "t2.micro"
# count = var.ec2_count
# tags = {
#   Name = "my-key"  
# }

# }

# variable "ubuntu_ami"{
#   description = "This is AMI for ubuntu ap-south-1"
#   type = string
#   default = "ami-00bb6a80f01f03502"

# }

# variable "ec2_count"{
#     description = "No of instances"
#     type = number
#     default = 2
# }


#List variable


resource "aws_instance" "ec2_example" {

   ami           = "ami-00bb6a80f01f03502"
   instance_type =  "t2.micro"
   count = 1

   tags = {
           Name = "Terraform EC2"
   }

}

resource "aws_iam_user" "example" {
  count = length(var.user_names)
  name  = var.user_names[count.index]
}

variable "user_names" {
  description = "IAM usernames"
  type        = list(string)
  default     = ["user1", "user2", "user3"]
}