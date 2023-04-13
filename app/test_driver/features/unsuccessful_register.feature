Feature: Register

  Background:
    Given the user has launched the app

  Scenario: unsuccessful user registration
    Given the user is in the register page
    When the user fills the "Register username" field with "user1@gmail.com"
    And the user fills the "Register password" field with "123456"
    And the user fills the "Confirm password" field with "123456"
    And the user taps "Accept terms and conditions"
    And the user taps "Register"
    Then an error message appears
    And the user is in the "Register page"
