#!/bin/bash
set -ex  # Activa modo debug para depuración

# Redirigir salida a logs para depuración
exec > >(tee /var/log/user_data.log | logger -t user-data ) 2>&1

echo "🔄 Actualizando paquetes..."
sudo yum update -y

echo "📦 Instalando dependencias necesarias..."
sudo yum install -y git docker python3 python3-pip unzip java-11-amazon-corretto-headless

# Instalar Docker Compose
echo "🐳 Instalando Docker Compose..."
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

echo "🐳 Iniciando y habilitando Docker..."
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker ec2-user

echo "📂 Clonando el repositorio de pruebas..."
sudo -u ec2-user -i bash <<EOF
cd ~
git clone https://github.com/sergioortiz17/api-backend-automation-bdd.git || true
cd api-backend-automation-bdd
git pull origin main
EOF

echo "🚀 Ejecutando pruebas y levantando Allure con Docker..."
sudo -u ec2-user -i bash <<EOF
cd ~/api-backend-automation-bdd
docker-compose down || true
docker-compose up --build -d
EOF

echo "🌎 Obteniendo IP pública de la instancia..."
INSTANCE_IP=$(curl -s http://169.254.169.254/latest/meta-data/public-ipv4)
echo "✅ El reporte de Allure está disponible en http://$INSTANCE_IP:8080"

echo "🎉 Configuración completada con éxito."
