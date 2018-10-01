# Security group for Cluster EKS
resource "aws_security_group" "sg-cluster-task-todo" {
  name        = "eks-task-todo-cluster"
  description = "Cluster communication with worker nodes"
  vpc_id      = "${aws_vpc.vpc-task-todo.id}"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "${var.cluster_name}"
  }
}

resource "aws_security_group_rule" "sg-ingress-node-https" {
  description              = "Allow pods to communicate with the cluster API Server"
  from_port                = 443
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.sg-cluster-task-todo.id}"
  source_security_group_id = "${aws_security_group.sg-cluster-task-todo.id}" //node
  to_port                  = 443
  type                     = "ingress"
}

# Security group for Node EKS