# 📌 Backend API Testing Automation

Este repositorio contiene un framework de **pruebas automatizadas** para APIs utilizando **Behave (BDD), Pytest, Requests y Allure Reports**. Además, permite ejecutar las pruebas en **una instancia de AWS EC2**, exponiendo los reportes de Allure en un puerto accesible.

## 🚀 **Tecnologías utilizadas**
- **Python 3.9+**
- **Behave (Gherkin/Cucumber)** para pruebas BDD
- **Pytest** para pruebas de integración
- **Requests** para interactuar con APIs
- **Allure Reports** para visualización de resultados
- **AWS EC2** para ejecución en la nube

---

## 📂 **Estructura del Proyecto**
```
api-backend-automation-bdd/
│── features/                  # Directorio principal de Behave
│   ├── reqres.feature         # Escenarios de pruebas para ReqRes API
│   ├── jsonplaceholder.feature # Escenarios de pruebas para JSONPlaceholder API
│   ├── steps/                 # Implementación de los pasos de Behave
│   │   ├── reqres_steps.py    # Pasos de prueba ReqRes API
│   │   ├── jsonplaceholder_steps.py # Pasos de prueba JSONPlaceholder API
│── src/                       # Código fuente (similar a POM, pero para APIs)
│   ├── api/                   # Módulo de las APIs
│   │   ├── reqres_api.py       # Lógica de llamadas a ReqRes API
│   │   ├── jsonplaceholder_api.py # Lógica de llamadas a JSONPlaceholder API
│── tests/                      # Pruebas con Pytest
│   ├── test_reqres.py          # Prueba unitaria/integración ReqRes API
│   ├── test_jsonplaceholder.py # Prueba unitaria/integración JSONPlaceholder API
│── reports/                    # Reportes de Allure
│── requirements.txt             # Dependencias del proyecto
│── behave.ini                   # Configuración de Behave
│── pytest.ini                   # Configuración de Pytest
│── .github/workflows/test.yml   # Configuración de GitHub Actions
│── README.md                    # Documentación
│── .gitignore                    # Archivos ignorados
```

---

## 📌 **Cómo correrlo localmente**
### **1️⃣ Clonar el repositorio**
```bash
git clone https://github.com/sergioortiz17/api-backend-automation-bdd.git
cd api-backend-automation-bdd
```

### **2️⃣ Crear un entorno virtual y activarlo**
```bash
python3 -m venv venv
source venv/bin/activate  # (Windows: venv\Scripts\activate)
```

### **3️⃣ Instalar dependencias**
```bash
pip install -r requirements.txt
```

### **4️⃣ Ejecutar las pruebas**
#### 🔹 **Ejecutar pruebas Behave (BDD)**
```bash
behave --format allure_behave.formatter:AllureFormatter -o reportes/
```

#### 🔹 **Ejecutar pruebas Pytest**
```bash
pytest tests --alluredir=reports/allure-results
```

### **5️⃣ Ver reportes con Allure**
```bash
allure serve reportes/allure-results
```

---

## 🌍 **Cómo ejecutarlo en una instancia AWS EC2**

### **1️⃣ Lanzar una instancia AWS EC2**
- Seleccionar **Amazon Linux 2** o **Ubuntu**.
- Configurar el grupo de seguridad para abrir el **puerto 8080** (para ver Allure Reports).
- En la sección **User Data**, agregar el siguiente script:

```bash
#!/bin/bash
set -ex

sudo yum update -y
sudo yum install -y git docker python3 python3-pip unzip

sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker ec2-user

wget -qO - https://github.com/allure-framework/allure2/releases/download/2.21.0/allure-2.21.0.tgz | sudo tar -xz -C /opt/
sudo ln -s /opt/allure-2.21.0/bin/allure /usr/bin/allure

sudo pip3 install virtualenv
sudo -u ec2-user bash -c 'python3 -m venv ~/backend-venv'

sudo -u ec2-user -i bash <<EOF
cd ~
git clone https://github.com/sergioortiz17/api-backend-automation-bdd.git
EOF

sudo -u ec2-user -i bash <<EOF
source ~/backend-venv/bin/activate
cd ~/api-backend-automation-bdd
pip install -r requirements.txt
EOF

sudo -u ec2-user -i bash <<EOF
source ~/backend-venv/bin/activate
cd ~/api-backend-automation-bdd
behave --format pretty --outfile=reports/allure-results
pytest tests --alluredir=reports/allure-results
EOF

sudo -u ec2-user -i bash <<EOF
source ~/backend-venv/bin/activate
cd ~/api-backend-automation-bdd
nohup allure serve reports/allure-results --host 0.0.0.0 --port 8080 > ~/allure.log 2>&1 &
EOF

INSTANCE_IP=$(curl -s http://169.254.169.254/latest/meta-data/public-ipv4)
echo "✅ El reporte de Allure está disponible en http://$INSTANCE_IP:8080"
```

### **2️⃣ Acceder al reporte de Allure**
1. Una vez que la instancia esté en ejecución, obtener la IP pública.
2. Acceder al reporte de Allure desde el navegador:
   ```
   http://<IP_PUBLICA_DE_LA_INSTANCIA>:8080
   ```

---

## ✅ **Integración con CI/CD en GitHub Actions**
Las pruebas se ejecutan automáticamente en cada **push** o **pull request** al repositorio.

📌 **Ver configuración en:** `.github/workflows/test.yml`

Para ver los resultados:
1. Ir a **GitHub > Actions**.
2. Seleccionar la ejecución más reciente.
3. Ver los logs y reportes generados.

---

## 📌 **Contacto y Contribuciones**
Si quieres contribuir con este proyecto:
1. **Haz un fork** del repositorio.
2. **Crea una rama** para tu mejora (`git checkout -b feature/nueva-mejora`).
3. **Haz un pull request** explicando los cambios.

📌 **Cualquier duda o sugerencia, contáctame en GitHub!** 🚀

