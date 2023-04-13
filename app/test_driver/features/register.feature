Feature: Register
  As a new user, 
  I want be able to register 
  so that I can use the application

  Background:
    Given the user has launched the app
    And the user is in the "Login page"
    And the user taps "Change"

  Scenario: successful user registration
    Given the user is in the "Register page"
    When the user fills the "Register username" field with "user.1@gmail.com"
    And the user fills the "Register password" field with "123456"
    And the user fills the "Confirm password" field with "123456"
    And the user taps "Accept terms and conditions"
    And the user taps "Register"
    Then the user is in the "Home page"