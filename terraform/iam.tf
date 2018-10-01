# Cluster Roles and Policies
resource "aws_iam_role" "cluster-role" {
  name = "cluster-${var.role_name}"
  description = "Cluster ${var.role_description}"
  assume_role_policy = <<CLUSTER
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
CLUSTER
}

resource "aws_iam_role_policy_attachment" "cluster-role-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = "${aws_iam_role.cluster-role.name}"
}

resource "aws_iam_role_policy_attachment" "cluster-role-AmazonEKSServicePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  role       = "${aws_iam_role.cluster-role.name}"
}

# Node Role and Policies
resource "aws_iam_role" "node-role" {
  name = "node-${var.role_name}"
  description = "Node ${var.role_description}"

  assume_role_policy = <<NODE
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
NODE
}

resource "aws_iam_role_policy_attachment" "node-role-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = "${aws_iam_role.node-role.name}"
}

resource "aws_iam_role_policy_attachment" "node-role-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = "${aws_iam_role.node-role.name}"
}

resource "aws_iam_role_policy_attachment" "node-role-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = "${aws_iam_role.node-role.name}"
}