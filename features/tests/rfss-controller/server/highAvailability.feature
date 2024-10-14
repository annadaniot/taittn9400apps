@WebUI  @RFSS-Controller
@tait_p25rc.db
Feature: RFSS Controller High Availability
  RFSS Controller High Availability Test Scenarios

  Background: Opening the RFSS Controller
    Given I opened the 'RFSS Controller'
    And I logged in as User: 'taitnet', Password: 'tait'
    When I select 'High Availability' from 'Server' on navbar
    Then I am in the 'ha-settings' page


  Scenario Outline: Fill the High Availability with Out Range Case Scenario
    Given I press the button with 'Edit' label
    And I fill the '<type>' field '<field_name>' with '<value>' under '<section>'
    When I press the button with 'Save' label
    And I press the button with 'Yes' label
    Then I got a toast show 'Update failed'

    Examples:
      | field_name            | value | type   | section                 |
      | Priority              | -1    | number | General                 |
      | Priority              | 0     | number | General                 |
      | Priority              | 21    | number | General                 |
      | Wait For Peer Timeout | -1    | number | General                 |
      | Wait For Peer Timeout | 0     | number | General                 |
      | Wait For Peer Timeout | 31    | number | General                 |
      | Transfer Rate         | -1    | number | Data Replication (DRBD) |
      | Transfer Rate         | 0     | number | Data Replication (DRBD) |
      | Transfer Rate         | 1001  | number | Data Replication (DRBD) |


  Scenario Outline: Fill the High Availability with Invalid IP Scenario
    Given I press the button with 'Edit' label
    When I fill the 'text' field '<field_name>' with '<value>' under '<section>'
    Then I am 'unable' to press the 'Save' button
    And I see a error message 'Invalid IP format'

    Examples:
      | field_name      | value    | section |
      | Network check A | ramdom   | General |
      | Network check A | 10.10.10 | General |
      | Network check B | 21       | General |
      | Network check B | 21       | General |
      | IP Address      | -1       | HA Peer |
      | IP Address      | 0        | HA Peer |


  Scenario: Fill the High Availability with Happy Case Scenario and saying no to updates
    Given I press the button with 'Edit' label
    And I fill the 'number' field 'Priority' with '2' under 'General'
    And I fill the 'number' field 'Wait For Peer Timeout' with '10' under 'General'
    And I fill the 'text' field 'Network check A' with '192.168.56.10' under 'General'
    And I fill the 'text' field 'Network check B' with '192.168.56.10' under 'General'
    And I fill the 'number' field 'Transfer Rate' with '500' under 'Data Replication (DRBD)'
    And I fill the 'text' field 'IP Address' with '192.168.56.5' under 'HA Peer'
    When I press the button with 'Save' label
    And I press the button with 'No' label
    Then I am in the 'ha-settings\/edit' page


  Scenario: Fill the High Availability with Happy Case Scenario and saying yes to updates
    Given I press the button with 'Edit' label
    And I fill the 'number' field 'Priority' with '2' under 'General'
    And I fill the 'number' field 'Wait For Peer Timeout' with '10' under 'General'
    And I fill the 'text' field 'Network check A' with '192.168.56.10' under 'General'
    And I fill the 'text' field 'Network check B' with '192.168.56.10' under 'General'
    And I fill the 'number' field 'Transfer Rate' with '500' under 'Data Replication (DRBD)'
    And I fill the 'text' field 'IP Address' with '192.168.56.5' under 'HA Peer'
    When I press the button with 'Save' label
    And I press the button with 'Yes' label
    Then I am in the 'ha-settings' page
    And I got a toast show 'Updated'
