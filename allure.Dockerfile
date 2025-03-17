FROM frankescobar/allure-docker-service:latest

WORKDIR /app
CMD ["allure", "serve", "reportes/", "--port", "8080"]
