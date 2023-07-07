# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile

## Creating an instance profile so we can connect to instance via SSM


resource "aws_iam_instance_profile" "tf_demo_instance_profile" {
  name = "tf_demo_instance_profile"
  role = aws_iam_role.tf_demo_instance_role.name
}

data "aws_iam_policy_document" "tf_demo_assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "tf_demo_instance_role" {
  name               = "tf_demo_instance_role"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.tf_demo_assume_role.json
}

resource "aws_iam_role_policy_attachment" "tf_demo_ssm_attach" {
  role       = aws_iam_role.tf_demo_instance_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}
