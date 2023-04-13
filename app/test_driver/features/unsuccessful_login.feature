Feature: Login

  Background:
    Given the user has launched the app

  Scenario: unsuccessful user log in
    Given the user is in the login page
    When the user fills the "Login username" field with "user1@gmail.com"
    And the user fills the "Login password" field with "1234567"
    And the user taps "Login"
    Then an error message appears
    And the user is in the "Login page"