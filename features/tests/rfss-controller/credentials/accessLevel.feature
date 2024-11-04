@WebUI @RFSS-Controller
@authentication.db @tait_p25rc.db
Feature: RFSS Controller - Access Level
  WebUI Testing for User Access Level

  Background: Opening the RFSS Controller
    Given I opened the 'RFSS Controller'
    Then I am in the 'login' page

  Scenario Outline: User can see they aceess level in title bar
    Given I logged in as User: '<username>', Password: 'tait'
    Then Login is successful
    And I am in the 'settings' page
    And I can see my '<access_level>' in the title bar

    Examples:
      | username    | access_level |
      | test_user_1 | Read/Write   |
      | test_user_2 | Read only    |


  Scenario Outline: Read/Write User can modify <page> page
    Given I logged in as User: 'test_user_1', Password: 'tait'
    Then Login is successful
    When I select '<page>' from '<section>' on navbar
    Then I am in the '<url>' page
    And There is '<available_button>' button

    Examples:
      | section     | page              | url             | available_button |
      | Server      | Settings          | settings        | Edit             |
      | Server      | Licenses          | licenses        | Upload           |
      | Server      | High Availability | ha-settings     | Edit             |
      | Credentials | Password          | change-password | Save             |


  Scenario Outline: Read/Write User can modify <page> table
    Given I logged in as User: 'test_user_1', Password: 'tait'
    Then Login is successful
    When I select '<page>' from '<section>' on navbar
    Then I am in the '<url>' page
    When I select row '0' on the table
    Then There is '<available_button>' button

    Examples:
      | section     | page    | url           | available_button |
      | Files       | Logs    | logs-files    | Delete           |
      | Files       | Backups | backups-files | Delete           |
      | Files       | Backups | backups-files | Backup           |
      | Files       | Backups | backups-files | Restore          |
      | Files       | Backups | backups-files | Full Restore     |
      | Files       | Backups | backups-files | Upload           |
      | Credentials | Users   | users         | Edit             |


  Scenario Outline: Read Only User can modify Password page
    Given I logged in as User: 'test_user_2', Password: 'tait'
    Then Login is successful
    When I select 'Password' from 'Credentials' on navbar
    Then I am in the 'change-password' page
    And There is 'Save' button


  Scenario Outline: Read Only User can not modify <page> page
    Given I logged in as User: 'test_user_2', Password: 'tait'
    Then Login is successful
    When I select '<page>' from '<section>' on navbar
    Then I am in the '<url>' page
    And There is no '<available_button>' button

    Examples:
      | section | page              | url         | available_button |
      | Server  | Settings          | settings    | Edit             |
      | Server  | Licenses          | licenses    | Upload           |
      | Server  | High Availability | ha-settings | Edit             |


  Scenario Outline: Read Only User can not modify <page> table
    Given I logged in as User: 'test_user_2', Password: 'tait'
    Then Login is successful
    When I select '<page>' from '<section>' on navbar
    Then I am in the '<url>' page
    When I select row '0' on the table
    Then There is no '<available_button>' button

    Examples:
      | section     | page    | url           | available_button |
      | Files       | Logs    | logs-files    | Delete           |
      | Files       | Backups | backups-files | Delete           |
      | Files       | Backups | backups-files | Backup           |
      | Files       | Backups | backups-files | Restore          |
      | Files       | Backups | backups-files | Full Restore     |
      | Files       | Backups | backups-files | Upload           |
      | Credentials | Users   | users         | Edit             |


  Scenario: Disabled user can not login
    Given I logged in as User: 'test_user_3', Password: 'tait'
    Then Error dialog box is show on the page
    And I am in the 'login' page
