Feature: Browse News articles
  In order to find the news articles they are interested in
  a website visitor
  will be able to browse and filter articles by region, sector, category and date

  Scenario: Browse all articles
    Given there are many news articles
    When I go to the News section of the website
    Then I should see a paginated list of articles

  Scenario: Archive
    Given there are many news articles that have been created over the last few years
    When I go to the News section of the website
    Then should see an archive list in the sidebar
    And I should be able use it to view articles to by specific month or year

  Scenario: Filters for category
    Given there are many news articles assigned to Categories
    When I go to the News section of the website
    Then I should see a list of Categories within the sidebar
    And when I choose a Category
    Then I should see only articles assigned to the Category

  Scenario: Filter by Author
    Given there are many news articles created by different authors
    When I go to the News section of the website
    Then I should see a list of Authors within the sidebar
    And when I choose a Author
    Then I should see only articles created by that author

  Scenario: Recent articles
    Given there are many news articles assigned to Categories
    When I go to the News section of the website
    Then I should see the 3 most recent articles in the sidebar
    And when I choose a Category
    Then the recent articles should reflect the Category

  Scenario: Related articles
    Given there are many news articles
    When I view an article
    Then I should see Articles related to the one I am viewing in the sidebar
    And the relation should be based on keywords

  Scenario: RSS Feed
    Given there are many news articles assigned to Categories
    Then I should be able to subscribe to an RSS feed
    And when I choose a Category
    Then the RSS feed should reflect the Category
