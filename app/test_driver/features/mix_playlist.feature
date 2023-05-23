Feature: Create playlist
  As a user, 
  I want to be able to mix my playlist with other users' playlists 
  so that a new list of songs is created

  Background: 
    Given I have launched the app
    And I have logged in using the account "user1@gmail.com"
    And I am on the home page
    And I tap the "mix playlist" button

  Scenario: mix own playlists
    Given I am on the "mix playlist page"
    When I tap the "mix my own playlist" button
    And I am on the "mix from user library page"
    And I tap the "banana" icon
    And I am on the "mix from user library page"
    And I tap the "batata" icon
    Then I am on the "final mixed playlist page"

  Scenario: mix with friend's playlist
    Given I am on the "mix playlist page"
    When I tap the "mix playlists with friend" button
    And I am on the "choose friend page"
    And I tap the "user2" label
    And I am on the "friend's library page"
    And I tap the "apple" icon
    And I am on the "mix from user library page"
    And I tap the "banana" icon
    Then I am on the "final mixed playlist page"