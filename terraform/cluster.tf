resource "aws_eks_cluster" "cluster-task-todo" {
  name     = "cluster-${var.label}"
  role_arn = "${aws_iam_role.cluster-role.arn}"

  vpc_config {
    security_group_ids = ["${aws_security_group.sg-cluster-task-todo.id}"]
    subnet_ids         = ["${aws_subnet.subnet-task-todo.*.id}"]
  }

  depends_on = [
    "aws_iam_role_policy_attachment.cluster-role-AmazonEKSClusterPolicy",
    "aws_iam_role_policy_attachment.cluster-role-AmazonEKSServicePolicy"
  ]
}