Feature: Login
  As a user,
  I want to be able to log in
  so that I can access the app

  Background:
    Given the user has launched the app

  Scenario: successful user log in
    Given the user is in the login page
    When the user fills the "Login username" field with "user1@gmail.com"
    And the user fills the "Login password" field with "123456"
    And the user taps "Login"
    Then the user is in the home page