resource "aws_iam_instance_profile" "worker-profile" {
  name = "profile-worker-eks"
  role = "${aws_iam_role.worker-role.name}"
}

data "aws_ami" "eks-worker" {
  filter {
    name   = "name"
    values = ["amazon-eks-node-v*"]
  }

  most_recent = true
  owners      = ["602401143452"] # Amazon EKS AMI Account ID
}

locals {
  worker-userdata = <<USERDATA
#!/bin/bash
set -o xtrace
/etc/eks/bootstrap.sh --apiserver-endpoint '${aws_eks_cluster.cluster-task-todo.endpoint}' --b64-cluster-ca '${aws_eks_cluster.cluster-task-todo.certificate_authority.0.data}' '${var.label}'
USERDATA
}

resource "aws_launch_configuration" "launch-task-todo" {
  associate_public_ip_address = true
  iam_instance_profile        = "${aws_iam_instance_profile.worker-profile.name}"
  image_id                    = "${data.aws_ami.eks-worker.id}"
  instance_type               = "m4.large"
  name_prefix                 = "launch-task-todo"
  security_groups             = ["${aws_security_group.sg-worker-task-todo.id}"]
  user_data_base64            = "${base64encode(local.worker-userdata)}"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "autoscaling-task-todo" {
  desired_capacity     = 2
  launch_configuration = "${aws_launch_configuration.launch-task-todo.id}"
  max_size             = 2
  min_size             = 1
  name                 = "autoscaling-task-todo"
  vpc_zone_identifier  = ["${aws_subnet.subnet-task-todo.*.id}"]

  tag {
    key                 = "Name"
    value               = "autoscaling-task-todo"
    propagate_at_launch = true
  }

  tag {
    key                 = "kubernetes.io/cluster/${var.label}"
    value               = "owned"
    propagate_at_launch = true
  }
}
