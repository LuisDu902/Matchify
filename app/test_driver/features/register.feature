Feature: Register
  As a new user, 
  I want be able to register 
  so that I can use the application

  Background:
    Given I have launched the app

  Scenario: successful user registration
    Given I am on the register page
    When I fill the "register username" field with "register@gmail.com"
    And I fill the "register password" field with "123456"
    And I fill the "confirm password" field with "123456"
    And I tap the "accept terms and conditions" button
    And I tap the "register" button
    Then I am on the home page
    And I have successfully registered

  Scenario: unsuccessful user registration
    Given I am on the register page
    When I fill the "register username" field with "user1@gmail.com"
    And I fill the "register password" field with "123456"
    And I fill the "confirm password" field with "123456"
    And I tap the "accept terms and conditions" button
    And I tap the "register" button
    Then an error message appears
    And I am on the "register page"
