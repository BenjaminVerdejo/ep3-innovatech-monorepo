# Buscar el rol existente de AWS Academy
data "aws_iam_role" "lab_role" {
  name = "LabRole"
}

# Definición del Clúster EKS
resource "aws_eks_cluster" "innovatech" {
  name     = "innovatech-cluster"
  role_arn = data.aws_iam_role.lab_role.arn

  vpc_config {
    subnet_ids = [aws_subnet.public_1.id, aws_subnet.public_2.id]
  }
}

# Grupo de Nodos con Escalabilidad Integrada (Pauta IE3)
resource "aws_eks_node_group" "nodos" {
  cluster_name    = aws_eks_cluster.innovatech.name
  node_group_name = "nodos-productivos"
  node_role_arn   = data.aws_iam_role.lab_role.arn
  subnet_ids      = [aws_subnet.public_1.id, aws_subnet.public_2.id]

  instance_types = ["t3.medium"]

  scaling_config {
    desired_size = 2  # Alta disponibilidad base
    max_size     = 4  # Margen de crecimiento para Autoscaling
    min_size     = 2
  }

  update_config {
    max_unavailable = 1
  }
}