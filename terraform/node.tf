resource "aws_iam_instance_profile" "node-profile" {
  name = "profile-node-eks"
  role = "${aws_iam_role.node-role.name}"
}

