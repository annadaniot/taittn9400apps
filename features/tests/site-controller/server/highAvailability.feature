@WebUI @Site-Controller
@tait_p25sc.db
Feature: Site Controller High Availability
  Site Controller High Availability Test Scenarios

  Background: Opening the Site Controller
    Given I opened the 'Site Controller'
    And I logged in as User: 'taitnet', Password: 'tait'
    When I select 'High Availability' from 'Server' on navbar
    Then I am in the 'ha-settings' page


  Scenario Outline: Fill the High Availability with Out Range Case Scenario
    Given I press the button with 'Edit' label
    And I fill the '<type>' field '<field_name>' with '<value>' under '<section>'
    When I press the button with 'Save' label
    And I press the button with 'Yes' label
    Then I got a toast show 'Error'

    Examples:
      | field_name            | value | type   | section |
      | Priority              | -1    | number | General |
      | Priority              | 0     | number | General |
      | Priority              | 21    | number | General |
      | Wait For Peer Timeout | -1    | number | General |
      | Wait For Peer Timeout | 0     | number | General |
      | Wait For Peer Timeout | 31    | number | General |


  Scenario Outline: Fill the High Availability with Invalid IP Scenario
    Given I press the button with 'Edit' label
    When I fill the 'text' field '<field_name>' with '<value>' under '<section>'
    Then I am 'unable' to press the 'Save' button
    And I see an error message 'Invalid IP format'

    Examples:
      | field_name      | value    | section |
      | Network check A | ramdom   | General |
      | Network check A | 10.10.10 | General |
      | Network check B | 21       | General |
      | Network check B | 245g245  | General |
      | IP Address      | -1       | HA Peer |
      | IP Address      | 0        | HA Peer |


  Scenario: Fill the High Availability with Happy Case Scenario and saying no to updates
    Given I press the button with 'Edit' label
    And I fill the 'number' field 'Priority' with '2' under 'General'
    And I fill the 'number' field 'Wait For Peer Timeout' with '10' under 'General'
    And I fill the 'text' field 'Network check A' with '10.214.191.201' under 'General'
    And I fill the 'text' field 'Network check B' with '10.214.191.204' under 'General'
    When I press the button with 'Save' label
    And I press the button with 'No' label
    Then I am in the 'ha-settings\/edit' page


  Scenario: Fill the High Availability with Happy Case Scenario and saying yes to updates
    Given I press the button with 'Edit' label
    And I fill the 'number' field 'Priority' with '2' under 'General'
    And I fill the 'number' field 'Wait For Peer Timeout' with '10' under 'General'
    And I fill the 'text' field 'Network check A' with '10.214.191.201' under 'General'
    And I fill the 'text' field 'Network check B' with '10.214.191.202' under 'General'
    When I press the button with 'Save' label
    And I press the button with 'Yes' label
    Then I am in the 'ha-settings' page
