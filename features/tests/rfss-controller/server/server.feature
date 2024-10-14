@WebUI  @RFSS-Controller
@tait_p25rc.db
Feature: RFSS Controller Server Setup
  RFSS Controller Server Setup Test Scenarios

  Background: Opening the RFSS Controller
    Given I opened the 'RFSS Controller'
    And I logged in as User: 'taitnet', Password: 'tait'
    Then I am in the 'settings' page


  Scenario: Turning the RFSS Controller Offline
    When I press the button with 'Edit' label
    And I choose 'Offline' mode from the dropdown
    Then I press the button with 'Save' label
    And RFSS Controller becomes 'Offline'


  Scenario: Turning the RFSS Controller Online
    When I press the button with 'Edit' label
    And I choose 'Online' mode from the dropdown
    Then I press the button with 'Save' label
    And RFSS Controller becomes 'Online'


  Scenario Outline: RFSS Controller Active IP Address are Invalid IP
    When I press the button with 'Edit' label
    And I fill the 'text' field 'RFSS Manager' with '<rfss_ip>' under 'Active IP Address'
    And I fill the 'text' field 'Fleet Manager' with '<fleet_ip>' under 'Active IP Address'
    Then I am '<action>' to press the 'Save' button

    Examples:
      | rfss_ip       | fleet_ip  | action |
      | ramdom_string | 127.0.0.1 | unable |
      # TODO: This should be unable
      | 127.0.0.1     | 127.0.0.1 | able   |


  Scenario: RFSS Controller Active IP Address are valid IP
    Given I press the button with 'Edit' label
    When I choose 'Online' mode from the dropdown
    And I fill the 'text' field 'RFSS Manager' with '10.214.191.200' under 'Active IP Address'
    And I fill the 'text' field 'Fleet Manager' with '10.214.191.201' under 'Active IP Address'
    And I press the button with 'Save' label
    Then RFSS Controller becomes 'Online'
    And There is a link to the 'RFSS Manager' on status bar
    And There is a link to the 'Fleet Manager' on status bar


  Scenario Outline: RFSS Controller username Link is Clickable
    Given There is a link to the '<app_name>' on status bar
    When I press the '<app_name>' link on status bar
    Then I got in a new page which is '<page_name>' page

    Examples:
      | app_name      | fleet_ip       | page_name |
      | RFSS Manager  | 10.214.191.200 | WebUI     |
      | Fleet Manager | 10.214.191.201 | p25fm     |


  Scenario: RFSS Controller username Link is Clickable
    Given I press the 'taitnet (Read/Write)' link
    Then I am in the 'change-password' page


  Scenario: RFSS Controller Administration Link is Clickable
    When I press the 'Administration' link
    Then The Administration App is shown


  Scenario: RFSS Controller About Link is Clickable
    When I press the About link
    Then The About dialog is shown


  Scenario: RFSS Controller Help Link is Clickable
    When I press the Help link
    Then I got in a new page which is 'Help' page
