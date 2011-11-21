Feature: Latest articles component
  In order to promote the most recent news articles
  a website editor
  will be able to place a list of latest articles within content

  Background:
    Given there are many news articles assigned to Categories

  Scenario: Add Latest Article Component
    When I am editing content
    Then I should be able to add a "Latest Articles" component

  @javascript
  Scenario: Filter the articles that appear
    When I am editing a "Latest Articles" component
    Then I should be able to filter the articles that appear in the component by sector, region or category
    And I should be able to filter by a combination of any of the above

