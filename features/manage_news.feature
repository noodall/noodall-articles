Feature: Manage news
  In order to keep the news on the website up to date
  a website editor
  will be able to manage the news articles

  Scenario: Create an article
    Given I am on the tree admin page
    And I navigate to the 'News' branch
    Then I should be able to add Articles the News branch

  @javascript
  Scenario: Assign an article to categories
    Given articles exist with categories assigned
    And I am editing an Article
    When I start typing in the categories field
    Then I should see suggestions of existing categories I could assign to the article
    And I should be able to assign the article to multiple new or existing categories

  Scenario: Adding an asset to an Article
    Given I am editing an Article
    When I add an image to the body of an article
    Then it should be used as the article thumbnail
