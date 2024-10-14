@WebUI @RFSS-Controller
Feature: RFSS Controller Logs
  RFSS Controller Logs Test Scenarios

  Background: Logging and go to logs page on RFSS Controller
    Given I opened the 'RFSS Controller'
    And I logged in as User: 'taitnet', Password: 'tait'
    When I select 'Logs' from 'Files' on navbar
    Then I am in the 'logs-files' page


  Scenario: RFSS Controller Download log file
    Given There is at less '2' rows in the table
    When I press the name of the first row
    Then The first file is get downloaded


  Scenario: RFSS Controller log table sort Last Modified in DESC as default
    Given There is at less '2' rows in the table
    And The tables is not sort on table as default
    Then The 'string' under the 'Last Modified' is in 'DESC' order


  Scenario Outline: Sort RFSS Controller logs table with column <column>
    Given There is at less '2' rows in the table
    When I sort the table with '<column>' in ASC
    Then The '<column_type>' under the '<column>' is in 'ASC' order
    When I sort the table with '<column>' in DESC
    Then The '<column_type>' under the '<column>' is in 'DESC' order

    Examples:
      | column        | column_type |
      | Name          | string      |
      | Last Modified | string      |
      | Size (bytes)  | number      |


  Scenario Outline: Filter RFSS Controller logs table
    Given There is at less '2' rows in the table
    When I input '<filter>' to the filter box
    Then All displayed rows contain '<filter>'

    Examples:
      | filter        |
      | .log          |
      | Rnc           |
      | p25rc         |
      | ramdom_string |
