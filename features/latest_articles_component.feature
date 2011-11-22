Feature: Latest articles component
  In order to promote the most recent news articles
  a website editor
  will be able to place a list of latest articles within content

  Background:
    Given there are many news articles assigned to Categories

  @javascript
  Scenario: Add Latest Article Component
    When I place a "Latest Articles" component in a slot
    And I view the content
    Then should see a list of the 3 latest articles in the slot

  @javascript
  Scenario: Choose Category of the articles that appear
    When I am editing a "Latest Articles" component
    Then I should be able to filter the articles that appear in the component by category

