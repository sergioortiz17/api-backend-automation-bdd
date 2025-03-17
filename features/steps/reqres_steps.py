import allure
from behave import given, when, then
from src.api.reqres_api import ReqResAPI

@given('quiero crear un usuario llamado "{name}" con el trabajo "{job}"')
def step_given_crear_usuario(context, name, job):
    context.api = ReqResAPI()
    context.name = name
    context.job = job

@when("realizo la solicitud a ReqRes API")
def step_when_realizo_solicitud(context):
    response = context.api.create_user(context.name, context.job)
    context.response = response.json()
    context.status_code = response.status_code

    allure.attach(
        str(context.response), 
        name="API Response",
        attachment_type=allure.attachment_type.JSON
    )

@then("la respuesta debe tener el código {status_code}")
def step_then_verificar_codigo(context, status_code):
    assert context.status_code == int(status_code), f"Esperado: {status_code}, Obtenido: {context.status_code}"

@then('el nombre del usuario debe ser "{expected_name}"')
def step_then_verificar_nombre(context, expected_name):
    assert context.response["name"] == expected_name, f"Esperado: {expected_name}, Obtenido: {context.response['name']}"

@then('el trabajo del usuario debe ser "{expected_job}"')
def step_then_verificar_trabajo(context, expected_job):
    assert context.response["job"] == expected_job, f"Esperado: {expected_job}, Obtenido: {context.response['job']}"
