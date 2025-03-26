Feature: Pruebas de integración con ReqRes API

  Scenario Outline: Crear un usuario exitosamente con diferentes datos
    Given quiero crear un usuario llamado "<name>" con el trabajo "<job>"
    When realizo la solicitud a ReqRes API
    Then la respuesta debe tener el código 201
    And el nombre del usuario debe ser "<name>"
    And el trabajo del usuario debe ser "<job>"

    Examples:
      | name             | job            |
      | Sergio Ortiz     | QA Engineer    |
      | Jane Smith       | Developer      |
      | Gabriela Ortiz   | Data Analyst   |
      | Jazmin Luna      | QA Automation Engineer |
      | Nico Martinez    | iOS Developer Engineer |
      | Cris Benelli     | Android Developer Engineer |
      | Ignacio  | Director rrhh |
