FROM openjdk:11-jre-slim

WORKDIR /app
RUN wget -qO - https://github.com/allure-framework/allure2/releases/download/2.21.0/allure-2.21.0.tgz | tar -xz -C /opt/
RUN ln -s /opt/allure-2.21.0/bin/allure /usr/bin/allure

CMD ["allure", "serve", "reportes/", "--port", "8080"]
