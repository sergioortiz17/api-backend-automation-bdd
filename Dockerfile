FROM python:3.9

WORKDIR /app
COPY . /app

RUN pip install --no-cache-dir -r requirements.txt
RUN pip install "urllib3<2.0" --force-reinstall
RUN pip install allure-behave==2.13.2 allure-python-commons==2.13.2 --force-reinstall
RUN pip install requests<=2.29.0

CMD ["behave", "-f", "allure_behave.formatter:AllureFormatter", "-o", "reportes/", "features/"]
