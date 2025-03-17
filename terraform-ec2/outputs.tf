output "instance_public_ip" {
  description = "IP pública de la instancia EC2"
  value       = aws_instance.ec2_basic.public_ip
}
