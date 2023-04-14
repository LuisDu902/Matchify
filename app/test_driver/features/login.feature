Feature: Login
  As a user,
  I want to be able to log in
  so that I can access the app

  Background: 
    Given the user has launched the app

  Scenario: successful user log in
    Given the user is in the login page
    When the user fills the "login username" field with "user1@gmail.com"
    And the user fills the "login password" field with "123456"
    And the user taps "login"
    Then the user is in the home page

  Scenario: unsuccessful user log in
    Given the user is in the login page
    When the user fills the "login username" field with "user1@gmail.com"
    And the user fills the "login password" field with "1234567"
    And the user taps "login"
    Then an error message appears
    And the user is in the "login page"
