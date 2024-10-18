@WebUI @Site-Controller
Feature: Site Controller Logs
  Site Controller Logs Test Scenarios

  Background: Logging and go to logs page on Site Controller
    Given I opened the 'Site Controller'
    And I logged in as User: 'taitnet', Password: 'tait'
    When I select 'Logs' from 'Files' on navbar
    Then I am in the 'logs-files' page


  Scenario: Site Controller Download log file
    Given There is at less '2' rows in the table
    When I press the name of the first row on RC
    Then The first file is get downloaded from RC


  Scenario Outline: Sort Site Controller logs table with column <column>
    Given There is at less '2' rows in the table
    When I sort the table with '<column>' in ASC
    Then The '<column_type>' under the '<column>' is in 'ASC' order
    When I sort the table with '<column>' in DESC
    Then The '<column_type>' under the '<column>' is in 'DESC' order

    Examples:
      | column        | column_type |
      | Name          | string      |
      | Last Modified | datetime    |
      | Size (bytes)  | number      |


  Scenario Outline: Filter Site Controller logs table
    Given There is at less '2' rows in the table
    When I input '<filter>' to the filter box
    Then All displayed rows contain '<filter>'

    Examples:
      | filter        |
      | .log          |
      | Rnc           |
      | p25rc         |
      | ramdom_string |
