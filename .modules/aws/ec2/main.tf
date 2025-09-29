module "ec2-instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "5.8.0"
}
resource "aws_instance" "this" {
  //   count              =   var.count 
  ami                    = var.ami
  key_name               = var.key_name
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.vpc_security_group_ids


  tags = {
    Name = var.tags
  }

}
