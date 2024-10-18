@WebUI @RFSS-Manager
@configure @empty
Feature: RFSS Manager - RFSS External Devices
  Fills out the RFSS Manager External Devices page

  Background: Opening the RFSS Manager
    Given I opened the 'RFSS Manager'
    And I logged in as User: 'taitnet', Password: 'tait'
    When I select 'External Devices' from 'Configure' on navbar
    Then I am in the 'configure/external-devices' page


  Scenario Outline: Creating a <type> External Devices
    Given There is '<row_before>' rows in the table
    When I press the button with 'Create' label
    Then I am in the 'configure/external-devices/create' page
    When I fill the 'text' field 'Name' with '<name>' under 'Identity'
    And I choose '<type>' option from the 'External Device Type' dropdown under 'Identity' section
    And I fill the 'text' field 'WACN ID' with '<wacn_id>' under 'Identity'
    And I fill the 'text' field 'System ID' with '<system_id>' under 'Identity'
    And I fill the 'text' field 'RFSS ID' with '<rfss_id>' under 'Identity'
    And I fill the 'text' field 'IP Address' with '127.0.0.1' under 'Identity'
    And I choose '<capability>' option from the 'External Device Vocoder Mode Capability' dropdown under 'Identity' section
    And I press the button with 'Save' label
    Then There is '<row_after>' rows in the table

    Examples:
      | name    | type              | wacn_id | system_id | rfss_id | capability | row_before | row_after |
      | ED-RFSS | RFSS              | a4398   | 5         | 4       | Full rate  | 0          | 1         |
      | ED-CS   | Console Subsystem | a4398   | 5         | 5       | Half rate  | 1          | 2         |
      | ED-VR   | Voice Recorder    | a4398   | 5         | 6       | Native     | 2          | 3         |


  Scenario: Creating a Mobile IP Router External Devices
    Given There is '3' rows in the table
    When I press the button with 'Create' label
    Then I am in the 'configure/external-devices/create' page
    When I fill the 'text' field 'Name' with 'ED-MIPR' under 'Identity'
    And I choose 'Mobile IP Router' option from the 'External Device Type' dropdown under 'Identity' section
    And I fill the 'text' field 'IP Address' with '127.0.0.1' under 'Identity'
    And I press the button with 'Save' label
    Then There is '4' rows in the table


  Scenario: Creating a RFSS use Copy under table
    Given There is '4' rows in the table
    When I select row '0' on the table
    And I press the button with 'Copy' label
    And I fill the 'text' field 'Name' with 'ED-RFSS-copy' under 'Identity'
    And I choose 'RFSS' option from the 'External Device Type' dropdown under 'Identity' section
    And I fill the 'text' field 'RFSS ID' with '7' under 'Identity'
    And I fill the 'text' field 'IP Address' with '127.0.0.2' under 'Identity'
    And I choose 'None' option from the 'External Device Vocoder Mode Capability' dropdown under 'Identity' section
    And I press the button with 'Save' label
    Then There is '5' rows in the table


  Scenario: Link to External Devices details page
    Given There is '5' rows in the table
    When I click on the text in row '1' and column 'Name'
    Then I am in the 'configure/external-devices-status/3' page


  Scenario: Creating a External Devices use Copy under detail page
    Given There is '5' rows in the table
    When I click on the text in row '1' and column 'Name'
    Then I am in the 'configure/external-devices-status/3' page
    When I press the button with 'Copy' label
    And I fill the 'text' field 'Name' with 'ED-CS-copy' under 'Identity'
    And I choose 'Console Subsystem' option from the 'External Device Type' dropdown under 'Identity' section
    And I fill the 'text' field 'RFSS ID' with '8' under 'Identity'
    And I fill the 'text' field 'IP Address' with '127.0.0.3' under 'Identity'
    And I choose 'Full and half rate' option from the 'External Device Vocoder Mode Capability' dropdown under 'Identity' section
    And I press the button with 'Save' label
    Then I am in the 'configure/external-devices-status/3' page
    When I press the button with 'Back' label
    Then I am in the 'configure/external-devices' page
    And There is '6' rows in the table


  Scenario: Edit a External Devices use button under the table
    Given There is '6' rows in the table
    When I select row '2' on the table
    Then There is 'Edit' button
    When I press the button with 'Edit' label
    Then I am in the 'configure/external-devices/4' page


  Scenario: Edit a External Devices use button under detail page with vaild data
    Given There is '6' rows in the table
    When I click on the text in row '2' and column 'Name'
    Then I am in the 'configure/external-devices-status/4' page
    And There is 'Edit' button
    When I press the button with 'Edit' label
    Then I am in the 'configure/external-devices/4' page
    When I fill the 'text' field 'Name' with 'Edited-ED' under 'Identity'
    And I choose 'Voice Recorder' option from the 'External Device Type' dropdown under 'Identity' section
    And I fill the 'text' field 'WACN ID' with 'a4399' under 'Identity'
    And I fill the 'text' field 'System ID' with '2cc' under 'Identity'
    And I fill the 'text' field 'RFSS ID' with '1' under 'Identity'
    And I click on the check box 'External Device Use 4 Hex Digit Rfss Id' under 'Identity' section
    And I fill the 'text' field 'IP Address' with '127.0.0.9' under 'Identity'
    And I choose 'None' option from the 'External Device Vocoder Mode Capability' dropdown under 'Identity' section
    And I press the button with 'Save' label
    Then I am in the 'configure/external-devices-status/4' page
    And I can see the 'Name' is 'Edited-ED' under 'Identity' on the form
    And I can see the 'Type' is 'Voice Recorder' under 'Identity' on the form
    And I can see the 'WACN ID' is 'a4399' under 'Identity' on the form
    And I can see the 'System ID' is '2cc' under 'Identity' on the form
    And I can see the 'RFSS ID' is '1' under 'Identity' on the form
    And I can see the 'Use 4 Hex Digit RFSS ID' is 'Yes' under 'Identity' on the form
    And I can see the 'IP Address' is '127.0.0.9' under 'Identity' on the form
    And I can see the 'Vocoder mode capability' is 'None' under 'Identity' on the form


  Scenario Outline: Edit a External Devices form with invalid data
    Given There is '6' rows in the table
    When I select row '2' on the table
    And I press the button with 'Edit' label
    And I fill the 'text' field '<field_name>' with '<value>' under 'Identity'
    Then I see an error message '<error_msg>'
    And The button with 'Save' label is been disabled

    Examples:
      | field_name | value  | error_msg                         |
      | Name       | spa ce | Illegal characters in input value |
      | WACN ID    | 0      | Invalid Value (1 ~ FFFFE)         |
      | WACN ID    | fffff  | Invalid Value (1 ~ FFFFE)         |
      | WACN ID    | string | Invalid Hex value                 |
      | System ID  | 0      | Invalid Value (1 ~ FCC)           |
      | System ID  | fcd    | Invalid Value (1 ~ FCC)           |
      | System ID  | string | Invalid Hex value                 |
      | RFSS ID    | 0      | Invalid Value (1 ~ FFFF)          |
      | RFSS ID    | 10000  | Invalid Value (1 ~ FFFF)          |
      | RFSS ID    | string | Invalid Hex value                 |


  Scenario Outline: Filter RFSS Manager External Devices table
    Given There is at less '6' rows in the table
    When I input '<filter>' to the filter box
    Then There is '<left_user_count>' rows in the table

    Examples:
      | filter      | left_user_count |
      | 5           | 4               |
      | ALL         | 3               |
      | RFSS        | 2               |
      | ED-MIPR     | 1               |
      | random_test | 0               |


  Scenario Outline: Sort RFSS Manager External Devices table with column <column>
    Given There is at less '6' rows in the table
    When I sort the table with '<column>' in ASC
    Then The '<column_type>' under the '<column>' is in 'ASC' order
    When I sort the table with '<column>' in DESC
    Then The '<column_type>' under the '<column>' is in 'DESC' order

    Examples:
      | column      | column_type |
      | Link Status | string      |
      | Name        | string      |
      | IP Address  | string      |
      | WACN ID     | option-hex  |
      | System ID   | option-hex  |
      | RFSS ID     | option-hex  |
      | Type        | string      |
      | Agency      | string      |


  Scenario: Delete a External Devices
    Given There is '6' rows in the table
    When I select row '3' on the table
    And I press the button with 'Delete' label
    And I press the button with 'OK' label
    Then There is '5' rows in the table


  Scenario: Delete more then one External Devices
    Given There is '5' rows in the table
    When I select row '3' on the table
    When I select row '4' on the table
    And I press the button with 'Delete Many' label
    And I press the button with 'OK' label
    Then There is '3' rows in the table