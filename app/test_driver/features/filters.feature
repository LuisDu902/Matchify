Feature: Filters
  As a user, 
  I want to be able to select specific filters 
  so that only the songs that match those filters are displayed.

    Background:
      Given the user has logged in
      And the user chooses to create a new playlist
    
    Scenario: apply filters
      Given the user is in the filters page
      When the user taps on "Genre"
      And the user chooses "Funk" and "Pop"
      And the user taps on "Mood"
      And the user chooses "Happy" and "Energetic"
      And the user taps on "Continue"
      Then only the songs that match those filters are displayed