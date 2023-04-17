Feature: Filters
  As a user, 
  I want to be able to select specific filters 
  so that only the songs that match those filters are displayed.

  Background: 
    Given I have launched the app
    And I am on the home page
    And I tap the "create a new playlist" button

  Scenario: apply filters
    Given I am on the "filters page"
    When I tap the "Genre" button
    And I choose "Funk" and "Pop"
    And I tap the "Mood" button
    And I choose "Happy" and "Energetic"
    And I tap the "continue" button
    Then I am on the "swipe page"
