Feature: Pruebas de integración con JSONPlaceholder API

  Scenario Outline: Crear un post exitosamente con diferentes datos
    Given quiero crear un post con título "<title>" y cuerpo "<body>"
    When realizo la solicitud a JSONPlaceholder API
    Then la respuesta debe tener el código 201
    And el título del post debe ser "<title>"
    And el cuerpo del post debe ser "<body>"

    Examples:
      | title         | body                |
      | Test Post 1   | This is a test 1    |
      | Test Post 2   | This is a test 2    |
      # | Test Post 3   | This is a test 3    |
