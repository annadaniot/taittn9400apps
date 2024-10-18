@WebUI @Site-Controller
Feature: Site Controller Backups
  Site Controller Backups Test Scenarios

  Background: Logging and go to backups page on Site Controller
    Given I opened the 'Site Controller'
    And I logged in as User: 'taitnet', Password: 'tait'
    When I select 'Backups' from 'Files' on navbar
    Then I am in the 'backups-files' page


  Scenario: Site Controller Create Backup
    Given The tables is not sort on table as default
    And Save the name of the newest Controller backup
    When I press the button with 'Backup' label
    And A dialog shown 'Success' on the page
    Then There is a new Controller Backup


  Scenario: Site Controller Download Backup
    Given The tables is not sort on table as default
    And Save the name of the newest Controller backup
    When I press the name of the newest RC backup
    Then The newest RC backup is get downloaded


  Scenario: Site Controller Upload Backup
    Given The tables is not sort on table as default
    And Save the name of the newest Controller backup
    When I upload a RC backup file
    Then The backup show up in the table


  Scenario Outline: Filter Site Controller Backup table
    Given There is at less '2' rows in the table
    When I input '<filter>' to the filter box
    Then All displayed rows contain '<filter>'

    Examples:
      | filter              |
      | .tar.gz             |
      | ui-test-backup-file |
      | random_test         |


  Scenario: Site Controller Backups table sort Last Modified in DESC as default
    Given There is at less '2' rows in the table
    And The tables is not sort on table as default
    Then The 'datetime' under the 'Last Modified' is in 'DESC' order


  Scenario Outline: Sort Site Controller Backups table with column <column>
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


  Scenario: Site Controller Delete Backup
    Given There is at less '2' rows in the table
    And Save the name of the newest Controller backup
    When I sort the table with 'Last Modified' in DESC
    And I select row '0' on the table
    Then There is a button with 'Delete' label
    When I select row '1' on the table
    Then There is a button with 'Delete Many' label
    When I press the button with 'Delete Many' label
    And I press the button with 'OK' label
    Then The Controller Backup is been deleted
