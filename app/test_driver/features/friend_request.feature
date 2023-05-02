Feature: Accept or decline friend requests
  As a user, 
  I want to be able to accept or decline friend requests 
  so that I can increase/maintain the number of friends I have

  Background: 
    Given I have launched the app
    And user2 has sent me a friend request
    And I have logged in using the account "user1@gmail.com"
    And I am on the "home page"
    And I tap the "side bar" button
    And I tap the "friends" label
    And I tap the "requests" button

  Scenario: accept a friend request
    Given I am on the "requests page"
    When I tap the "accept request" icon
    Then I increased the number of friends I have

  Scenario: decline a friend request
    Given I am on the "friends page"
    When I tap the "requests" icon
    And I tap the "decline request" icon
    Then I declined a friend request
