Feature: Login
  As a user,
  I want to be able to log in
  so that I can access the app

  Background: 
    Given I have launched the app

  Scenario: successful user log in
    Given I am on the login page
    When I fill the "login username" field with "user1@gmail.com"
    And I fill the "login password" field with "123456"
    And I tap the "login" button
    Then I am on the "home page"

  Scenario: unsuccessful user log in
    Given I am on the login page
    When I fill the "login username" field with "user1@gmail.com"
    And I fill the "login password" field with "1234567"
    And I tap the "login" button
    Then an error message appears
    And I am on the "login page"
