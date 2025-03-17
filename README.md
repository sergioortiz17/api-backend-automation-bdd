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

### **2️⃣ Instalar dependencias**
```bash
pip3 install -r requirements.txt
```

### **3️⃣ Ejecutar las pruebas**
#### 🔹 **Ejecutar pruebas Behave (BDD)**
```bash
behave --format pretty --outfile=reports/allure-results
```

#### 🔹 **Ejecutar pruebas Pytest**
```bash
pytest tests --alluredir=reports/allure-results
```

### **4️⃣ Ver reportes con Allure**
```bash
allure serve reports/allure-results
```

---

## 🌍 **Cómo ejecutarlo en una instancia AWS EC2**

### **1️⃣ Lanzar una instancia AWS EC2**
- Seleccionar **Amazon Linux 2** o **Ubuntu**.
- Configurar el grupo de seguridad para abrir el **puerto 8080** (para ver Allure Reports).
- En la sección **User Data**, uso un script que configura la instancia clonando el repo e instalando sus dependencias y ejecutandolo


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

