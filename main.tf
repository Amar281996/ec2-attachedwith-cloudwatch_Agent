#Create a local variable to load User_data using templatefile function.
locals {
  userdata = templatefile("user-data.sh", {
    ssm_cloudwatch_config = aws_ssm_parameter.cwagent.name
  })
}
#Creating one EC2 resource to attach with cloudwatch agent
resource "aws_instance" "ec2-agent" {
  ami                  = "ami-0439517b5e436bdab"
  instance_type        = "t2.micro"
  iam_instance_profile = aws_iam_instance_profile.this.name
  user_data            = local.userdata
  tags                 = {
     Name = "EC2-cloudwatchagent"
      }
}
#Create SSM Parameter resource, and load its value from file clou-watchagent.json
resource "aws_ssm_parameter" "cwagent" {
  description = "Cloudwatch agent config to configure custom log"
  name        = "/cloudwatch-agent/config"
  type        = "String"
  value       = file("cloud-watchagent.json")
}