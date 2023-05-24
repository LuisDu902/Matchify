Feature: Create playlist
  As a user, 
  I want to be able to create a playlist after choosing five songs that I liked 
 
  Background: 
    Given I have launched the app
    And I am on the home page
    And I tap the "create a new playlist" button
    And I have chosen the filters to apply
    And I tap the "continue" button

  Scenario: skip a song
    Given I am on the swipe page
    And I tap the "play" button
    And I listen to a short clip of a song
    When I swipe left by 300 pixels on the "song image"
    And I tap the "play" button
    And I listen to a short clip of a song
    When I swipe left by 300 pixels on the "song image"
    And I tap the "play" button
    And I listen to a short clip of a song
    When I swipe left by 300 pixels on the "song image"
    And I tap the "play" button
    And I listen to a short clip of a song
    When I swipe left by 300 pixels on the "song image"
    And I tap the "play" button
    And I listen to a short clip of a song
    When I swipe left by 300 pixels on the "song image"
    Then a new playlist has been created
   
   