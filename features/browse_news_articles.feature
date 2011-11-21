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

  Scenario Outline: Filters for category, sector and region
    Given there are many news articles assigned to <Filter>s
    When I go to the News section of the website
    Then I should see a list of <Filter> within the sidebar
    And when I choose a <Filter>
    Then I should see only articles assigned to the <Filter>

    Scenarios: Filters
      | Filter   |
      | Sector   |
      | Region   |
      | Category |

  Scenario: Recent articles
    Given there are many news articles assigned to Sectors, categories and Regions
    When I go to the News section of the website
    Then I should see the 3 most recent articles in the sidebar
    When I have selected some filters
    Then the recent articles should reflect the filters

  Scenario: Related articles
    Given there are many news articles
    When I view an article
    Then I should see Articles related to the one I am viewing in the sidebar
    And the relation should be based on keywords

  Scenario: Multiple Filters
    Given there are many news articles assigned to Sectors, categories and Regions
    When I go to the News section of the website
    And choose a filter
    And then choose another filter
    Then both filters should be applied to the list

  Scenario: RSS Feed
    Given there are many news articles assigned to Sectors, categories and Regions
    Then I should be able to subscribe to an RSS feed
    When I have select some filters
    Then the RSS feed should reflect the filters
