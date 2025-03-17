resource "aws_security_group" "ec2_sg" {
  name        = "ec2_security_group"
  description = "Security group para permitir SSH, HTTP, y otros servicios"

  # Permitir SSH desde cualquier IP (0.0.0.0/0)
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Permitir SSH"
  }

  # Permitir HTTP desde cualquier IP (0.0.0.0/0)
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Permitir HTTP"
  }

  # Permitir HTTPS desde cualquier IP (0.0.0.0/0)
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Permitir HTTPS"
  }

  # Permitir acceso al frontend en el puerto 3000
  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Permitir acceso al frontend en el puerto 3000"
  }

  # Permitir acceso al backend en el puerto 8000
  ingress {
    from_port   = 8000
    to_port     = 8000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Permitir acceso al backend en el puerto 8000"
  }

    # Permitir acceso al backend en el puerto 8000
  ingress {
    from_port   = 9323
    to_port     = 9323
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Permitir acceso al reporte en 9323"
  }


  # Permitir acceso al servicio en el puerto 8080
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Permitir acceso al servicio en el puerto 8080"
  }

  # Permitir acceso al servicio en el puerto 7080
  ingress {
    from_port   = 7080
    to_port     = 7080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Permitir acceso al servicio en el puerto 7080"
  }

  # Permitir todo el tráfico de salida
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Permitir todo el trafico de salida"
  }
}

resource "aws_instance" "ec2_basic" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = "docker-compose"
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]

  user_data = templatefile("${path.module}/user_data.sh", {})

  tags = {
    Name = var.instance_name
  }
}
