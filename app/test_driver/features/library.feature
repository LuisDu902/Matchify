Feature: Library
  As a user, 
  I want to have access to a list of all the playlists I have created 
  so that I can keep track of how many playlists I have

  Background: 
    Given I have launched the app
    And I have logged in using the account "user1@gmail.com"
    And I am on the "home page"
    And I tap the "side bar" button
    And I tap the "library" label

  Scenario: access to created playlists
    Given I am on the "library page"
    When I tap the "banana" icon
    Then I am on the "playlist page"
    And I can see my playlist