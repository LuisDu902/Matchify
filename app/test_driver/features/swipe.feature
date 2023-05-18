Feature: Choose songs
  As a user, 
  I want to be able to choose songs I like by swiping left or right 
  so that those songs are added or not (respectively) to the playlist I am creating

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
    Then the song was skipped
   
   