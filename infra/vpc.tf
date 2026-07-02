# Configuración de la red (VPC)
resource "aws_vpc" "proyecto_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true  # Activa los nombres de host DNS automáticamente
  enable_dns_support   = true  # Activa la resolución DNS automáticamente

  tags = {
    Name = "proyecto-vpc"
  }
}

# Internet Gateway para dar salida a la calle
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.proyecto_vpc.id
  tags = { Name = "proyecto-igw" }
}

# Subredes Públicas (Zonas A y B para Alta Disponibilidad)
resource "aws_subnet" "public_1" {
  vpc_id            = aws_vpc.proyecto_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true # Asigna IP pública a las máquinas directamente
  tags              = { Name = "proyecto-subnet-public1-us-east-1a" }
}

resource "aws_subnet" "public_2" {
  vpc_id            = aws_vpc.proyecto_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = true # Asigna IP pública a las máquinas directamente
  tags              = { Name = "proyecto-subnet-public2-us-east-1b" }
}

# Tablas de enrutamiento y asignación del Gateway
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.proyecto_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.public_1.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.public_2.id
  route_table_id = aws_route_table.public_rt.id
}