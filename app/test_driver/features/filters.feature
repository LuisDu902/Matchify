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
    When I fill the "playlist size" field with "8"
    And I tap the "Genre" button
    And I choose "Funk" and "Pop"
    And I tap the "Decade" button
    And I choose "1970's" and "1980's"
    And I tap the "continue" button
    Then I am on the swipe page
