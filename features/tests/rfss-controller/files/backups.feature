@WebUI @RFSS-Controller
Feature: RFSS Controller Backups
  RFSS Controller Backups Test Scenarios

  Background: Logging and go to backups page on RFSS Controller
    Given I opened the 'RFSS Controller'
    And I logged in as User: 'taitnet', Password: 'tait'
    When I select 'Backups' from 'Files' on navbar
    Then I am in the 'backups-files' page


  Scenario: RFSS Controller Create Backup
    Given The tables is not sort on table as default
    And Save the name of the newest RC backup
    When I press the button with 'Backup' label
    And A dialog shown 'Backup Complete' on the page
    Then There is a new RC Backup


  Scenario: RFSS Controller Download Backup
    Given The tables is not sort on table as default
    And Save the name of the newest RC backup
    When I press the name of the newest RC backup
    Then The newest RC backup is get downloaded


  Scenario: RFSS Controller Upload Backup
    Given The tables is not sort on table as default
    And Save the name of the newest RC backup
    When I upload a backup file
    Then The backup show up in the table


  Scenario Outline: Filter RFSS Controller Backup table
    Given There is at less '2' rows in the table
    When I input '<filter>' to the filter box
    Then All displayed rows contain '<filter>'

    Examples:
      | filter              |
      | .tar.gz             |
      | ui-test-backup-file |
      | random_test         |


  Scenario: RFSS Controller Backups table sort Last Modified in DESC as default
    Given There is at less '2' rows in the table
    And The tables is not sort on table as default
    Then The 'string' under the 'Last Modified' is in 'DESC' order


  Scenario Outline: Sort RFSS Controller Backups table with column <column>
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


  Scenario: RFSS Controller Delete Backup
    Given There is at less '2' rows in the table
    And Save the name of the newest RC backup
    When I sort the table with 'Last Modified' in DESC
    And I select row '0' on the table
    Then There is a button with 'Delete' label
    When I select row '1' on the table
    Then There is a button with 'Delete Many' label
    When I press the button with 'Delete Many' label
    And I press the button with 'OK' label
    Then The RC Backup is been deleted
