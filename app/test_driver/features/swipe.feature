Feature: Choose songs
  As a user, 
  I want to be able to choose songs I like by swiping left or right 
  so that those songs are added or not (respectively) to the playlist I am creating

  Background: 
    Given the user has launched the app
    And the user is in the home page
    And the user taps "create a new playlist"
    And the user has chosen the filters to apply
    And the user taps "continue"

  Scenario: skip a song
    Given the user is in the "swipe page"
    And the user taps "play button"
    And the user listens to a short clip of a song
   
   