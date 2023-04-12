Feature: Login
  As a user,
  I want to be able to log in
  so that I can access the app

  Scenario: successful user log in
    Given the user is in the login page
    When the user fills the username field with "user1@gmail.com"
    And the user fills the password field with "123456"
    And the user taps "Log In"
    Then the user logs in