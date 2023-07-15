# # https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance#import
# # terraform import aws_instance.my_imported_resource i-0c35204194360bfbf (replace instance id with the one you created in the console)

# For the import - keep this as an empty block - the declare the values you are concerned with
# To get all the current values in AWS (and now your state) in your cmd line type: terraform state show aws_instance.my_imported_resource


resource "aws_instance" "my_imported_resource" {
  # ami               = "ami-06ca3ca175f37dd66"
  # instance_type     = "t2.micro"
  # availability_zone = "us-east-1a"
  # source_dest_check = true
  # subnet_id         = "subnet-05a956a7f87bb2ec9"
  # tags = {
  #   "Name" = "test-import"
  # }
  # tags_all = {
  #   "Name" = "test-import"
  # }
  # vpc_security_group_ids = [
  #   "sg-00f22cbe9bfde7ea2",
  # ]


}