Feature: Filters
  As a user, 
  I want to be able to select specific filters 
  so that only the songs that match those filters are displayed.

  Background: 
    Given the user has launched the app
    And the user is in the home page
    And the user taps "Create a new playlist"

  Scenario: apply filters
    Given the user is in the "Filters page"
    When the user taps "Genre"
    And the user chooses "Funk" and "Pop"
    And the user taps "Mood"
    And the user chooses "Happy" and "Energetic"
    And the user taps "Continue"
    Then the user is in the "Swipe page"
