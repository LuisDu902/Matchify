Feature: Friend request
  As a user, 
  I want to be able to add friends 
  so that I can see their playlists

  Background: 
    Given I have launched the app
    And I have logged in using the account "user1@gmail.com"
    And I am on the "home page"
    And I tap the "side bar" button
    And I tap the "add friend" label

  Scenario: successful friend request
    Given I am on the "add friend page"
    When I fill the "friend's username" field with "user3"
    And I tap the "send request" button
    Then a friend request is sent

  Scenario: unsuccessful friend request
    Given I am on the "add friend page"
    When I fill the "friend's username" field with "user1"
    And I tap the "send request" button
    Then a friend request is not sent