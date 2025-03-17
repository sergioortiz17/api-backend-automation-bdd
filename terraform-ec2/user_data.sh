#!/bin/bash
set -ex  # Activa modo debug para depuración

# Redirigir salida a logs para depuración
exec > >(tee /var/log/user_data.log | logger -t user-data ) 2>&1

echo "🔄 Actualizando paquetes..."
sudo yum update -y

echo "📦 Instalando dependencias necesarias..."
sudo yum install -y git docker python3 python3-pip unzip java-11-amazon-corretto-headless

echo "🐳 Iniciando y habilitando Docker..."
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker ec2-user

echo "💾 Instalando Allure..."
wget -qO - https://github.com/allure-framework/allure2/releases/download/2.21.0/allure-2.21.0.tgz | sudo tar -xz -C /opt/
sudo ln -s /opt/allure-2.21.0/bin/allure /usr/bin/allure

echo "📂 Clonando el repositorio de pruebas..."
sudo -u ec2-user -i bash <<EOF
cd ~
git clone https://github.com/sergioortiz17/api-backend-automation-bdd.git
cd api-backend-automation-bdd
EOF

echo "📌 Instalando dependencias del proyecto..."
sudo -u ec2-user -i bash <<EOF
pip3 install "urllib3<2.0" --force-reinstall
pip3 install allure-behave==2.13.2 allure-python-commons==2.13.2 --force-reinstall
pip3 install requests<=2.29.0
pip3 install -r ~/api-backend-automation-bdd/requirements.txt
EOF

echo "🚀 Ejecutando pruebas Behave con Allure y Pytest..."
sudo -u ec2-user -i bash <<EOF
cd ~/api-backend-automation-bdd
behave -f allure_behave.formatter:AllureFormatter -o reportes/ features/
EOF

echo "📊 Generando y sirviendo el reporte de Allure en el puerto 8080..."
sudo -u ec2-user -i bash <<EOF
cd ~/api-backend-automation-bdd
allure serve reportes/ --port 8080
EOF

echo "🌎 Obteniendo IP pública de la instancia..."
INSTANCE_IP=$(curl -s http://169.254.169.254/latest/meta-data/public-ipv4)
echo "✅ El reporte de Allure está disponible en http://$INSTANCE_IP:8080"

echo "🎉 Configuración completada con éxito."
