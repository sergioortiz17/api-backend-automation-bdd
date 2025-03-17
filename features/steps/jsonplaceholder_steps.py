import allure
from behave import given, when, then
from src.api.jsonplaceholder_api import JSONPlaceholderAPI

@given('quiero crear un post con título "{title}" y cuerpo "{body}"')
def step_given_crear_post(context, title, body):
    context.api = JSONPlaceholderAPI()
    context.title = title
    context.body = body

@when("realizo la solicitud a JSONPlaceholder API")
def step_when_realizo_solicitud(context):
    response = context.api.create_post(context.title, context.body, 1)
    context.response = response.json()
    context.status_code = response.status_code

    allure.attach(
        str(context.response), 
        name="API Response",
        attachment_type=allure.attachment_type.JSON
    )

@then("el título del post debe ser \"{expected_title}\"")
def step_then_verificar_titulo(context, expected_title):
    assert context.response["title"] == expected_title, f"Esperado: {expected_title}, Obtenido: {context.response['title']}"

@then("el cuerpo del post debe ser \"{expected_body}\"")
def step_then_verificar_cuerpo(context, expected_body):
    assert context.response["body"] == expected_body, f"Esperado: {expected_body}, Obtenido: {context.response['body']}"
