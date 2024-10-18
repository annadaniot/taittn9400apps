@WebUI @Site-Controller
@tait_p25sc.db
Feature: Site Controller Server Setup
  Site Controller Server Setup Test Scenarios

  Background: Opening the Site Controller
    Given I opened the 'Site Controller'
    And I logged in as User: 'taitnet', Password: 'tait'
    Then I am in the 'settings' page


  Scenario: Turning the Site Controller Offline
    When I press the button with 'Edit' label
    And I choose 'Offline' mode from the dropdown
    Then I press the button with 'Save' label
    And Controller becomes 'Offline'


  Scenario: Site Controller Active IP Address are valid IP
    Given I press the button with 'Edit' label
    When I choose 'Online' mode from the dropdown
    And I fill the 'text' field 'Name' with 'Test Site Controller' under 'General'
    And I fill the 'text' field 'Site Controller' with '10.214.191.204' under 'Active IP Address'
    And I press the button with 'Save' label
    Then Controller becomes 'Online'


  Scenario: Site Controller username Link is Clickable
    Given I press the 'taitnet (Read/Write)' link
    Then I am in the 'change-password' page


  Scenario: Site Controller Administration Link is Clickable
    When I press the 'Administration' link
    Then The Administration App is shown


  Scenario: Site Controller About Link is Clickable
    When I press the About link
    Then The About dialog is shown


  Scenario: Site Controller Help Link is Clickable
    When I press the Help link
    Then I got in a new page which is 'Help' page
