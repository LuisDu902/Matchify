Feature: Register
  As a new user, 
  I want be able to register 
  so that I can use the application

  Scenario: successful user registration
    Given the user is in the register page
    When the user fills the username field with "user10@gmail.com"
    And the user fills the password field with "123456"
    And the user taps "Register"
    Then the user logs in