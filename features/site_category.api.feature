Feature: SiteCategories API
  In order to intract with site_categories from dashboard
  SiteCategories API should be accessable by logged in users
  And anonymous user should not have accesss to API

  Scenario: Anonymous User should not have access to API
    Given I am not authenticated
    And there is a site_category named "Iran" in database
    When format is json and I go to the api v1 site_categories page
    Then I should get "401" status code
    When format is json and I go to "/api/v1/site_categories/1"
    Then I should get "401" status code
    When format is json and I send patch to "/api/v1/site_categories/1" with:
    """
    {"name":"oQJIrmCbAIqcHqgONVithNNtLjBFHoyybMwMzizZyMLRWNHQXm","description":"YGdAOLbpVwHUEPAvGuXsnoNgyfBnddfZWiOwAHIqOiQSZtdgGt"}
    """
    Then I should get "401" status code
    When format is json and I send post to "/api/v1/site_categories" with:
    """
    {"name":"iwxKLiCyJgWXkxvZWsPpDJtKAjJfIZAjOhNhcjwqMBBJFmUBtB","description":"ecLosJRIhcnFPaifABaFgYLWAYGRWgXoKmCLItkxmEfigDaHju"}
    """
    Then I should get "401" status code
    When format is json and I send delete to "/api/v1/site_categories/1"
    Then I should get "401" status code

  Scenario: Default response should be json
    Given I am authenticated
    When I go to the api v1 site_categories page
    Then response type should be application/json

  Scenario: Anonymous User via HTTP
    Given I am not authenticated
    When format is html and I go to the api v1 site_categories page
    Then I should be in sign in page

  Scenario: Anonymous USer via JSON format
    Given I am not authenticated
    When format is json and I go to the api v1 site_categories page
    Then I should get "401" status code

  Scenario: Logged in User via HTTP
    Given I am authenticated
    When format is html and I go to the api v1 site_categories page
    Then I should get unknown format exception
    #Then I should get "406" status code

  Scenario: Logged in User via JSON format
    Given I am authenticated
    When format is json and I go to the api v1 site_categories page
    Then the JSON should have 0 keys

  Scenario: Logged in User via JSON format And Initial Data
    Given I am authenticated
    And there is a site_category named "XYZ" in database
    When format is json and I go to the api v1 site_categories page
    Then the JSON should have 1 keys
    And the JSON at "0/name" should be "XYZ"

  Scenario: API should not response to "/new"
    Given I am authenticated
    When format is json and I go to "/api/v1/site_categories/new"
    Then action should not be found

  @javascript
  Scenario: Add New site_category
    Given I am authenticated
    When I go to "/dashboard#/site_categories/new"
    And fill in "name" with "XYZ"
    And click on "save"
    And wait for ajax to return
    Then there should be a site_category with "XYZ" as "name"

  @javascript
  Scenario: Edit site_category
    Given I am authenticated
    And there shouldn't be any site_category
    And there is a site_category named "XYZ" in database
    Then there should be a site_category with "XYZ" as "name"
    When I go to "/dashboard#/site_categories/1/edit"
    And fill in "name" with "XYZW"
    Then field "name" contains "XYZW"
    When click on "save"
    And wait for ajax to return
    Then there should be a site_category with "XYZW" as "name"

  Scenario: Delete site_category
    Given I am authenticated
    And there is a site_category named "ABC" in database
    And there is a site_category named "XYZ" in database
    When format is json and I send delete to "/api/v1/site_categories/1,2"
    Then the JSON at "msg" should be "Items removed successfully."
    And there shouldn't be any site_category
