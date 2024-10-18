@WebUI @RFSS-Manager
@configure @empty
Feature: RFSS Manager - RFSS Frequency Plan
  Fills out the RFSS Manager Frequency Plan page

  Background: Opening the RFSS Manager
    Given I opened the 'RFSS Manager'
    And I logged in as User: 'taitnet', Password: 'tait'
    When I select 'Frequency Plan' from 'Configure' on navbar
    Then I am in the 'configure/frequency-plan' page


  Scenario Outline: Creating a <channel_type> Frequency Plan
    Given There is '<row_before>' rows in the table
    When I press the button with 'Create' label
    Then I am in the 'configure/frequency-plan/create' page
    When I fill the 'text' field 'Name' with '<channel_type>' under 'Identity'
    And I fill the 'text' field 'Frequency Plan ID' with '<id>' under 'Identity'
    And I choose '<channel_type>' option from the 'Channel Type' dropdown under 'Identity' section
    And I fill the 'text' field 'Base Frequency (Hz)' with '152500000' under 'Identity'
    And I fill the 'text' field 'Transmit Offset (Hz)' with '3000000' under 'Identity'
    And I fill the 'text' field 'Channel Bandwidth (Hz)' with '12500' under 'Identity'
    And I fill the 'text' field 'Channel Spacing (Hz)' with '12500' under 'Identity'
    And I press the button with 'Save' label
    Then There is '<row_after>' rows in the table

    Examples:
      | channel_type | id | row_before | row_after |
      | FDMA         | 1  | 0          | 1         |
      | TDMA         | 2  | 1          | 2         |


  Scenario: Creating a Frequency Plan use Copy under table
    Given There is '2' rows in the table
    When I select row '0' on the table
    And I press the button with 'Copy' label
    And I fill the 'text' field 'Name' with 'TDMA-copy' under 'Identity'
    And I fill the 'text' field 'Frequency Plan ID' with '3' under 'Identity'
    And I choose 'TDMA' option from the 'Channel Type' dropdown under 'Identity' section
    And I fill the 'text' field 'Base Frequency (Hz)' with '112500000' under 'Identity'
    And I fill the 'text' field 'Transmit Offset (Hz)' with '2000000' under 'Identity'
    And I fill the 'text' field 'Channel Bandwidth (Hz)' with '11500' under 'Identity'
    And I fill the 'text' field 'Channel Spacing (Hz)' with '10500' under 'Identity'
    And I press the button with 'Save' label
    Then There is '3' rows in the table


  Scenario: Link to Frequency Plan details page
    Given There is '3' rows in the table
    When I click on the text in row '1' and column 'Name'
    Then I am in the 'configure/frequency-plan-status/3' page


  Scenario: Creating a Frequency Plan use Copy under detail page
    Given There is '3' rows in the table
    When I click on the text in row '1' and column 'Name'
    Then I am in the 'configure/frequency-plan-status/3' page
    When I press the button with 'Copy' label
    And I fill the 'text' field 'Name' with 'FDMA-copy' under 'Identity'
    And I fill the 'text' field 'Frequency Plan ID' with '4' under 'Identity'
    And I press the button with 'Save' label
    Then I am in the 'configure/frequency-plan-status/3' page
    When I press the button with 'Back' label
    Then I am in the 'configure/frequency-plan' page
    And There is '4' rows in the table


  Scenario: Edit a Frequency Plan use button under the table
    Given There is '4' rows in the table
    When I select row '2' on the table
    Then There is 'Edit' button
    When I press the button with 'Edit' label
    Then I am in the 'configure/frequency-plan/4' page


  Scenario: Edit a Frequency Plan use button under detail page with vaild data
    Given There is '4' rows in the table
    When I click on the text in row '2' and column 'Name'
    Then I am in the 'configure/frequency-plan-status/4' page
    And There is 'Edit' button
    When I press the button with 'Edit' label
    Then I am in the 'configure/frequency-plan/4' page
    When I fill the 'text' field 'Name' with 'EDIT_FP' under 'Identity'
    And I fill the 'text' field 'Frequency Plan ID' with '5' under 'Identity'
    And I choose 'FDMA' option from the 'Channel Type' dropdown under 'Identity' section
    And I fill the 'text' field 'Base Frequency (Hz)' with '122500000' under 'Identity'
    And I fill the 'text' field 'Transmit Offset (Hz)' with '400000' under 'Identity'
    And I fill the 'text' field 'Channel Bandwidth (Hz)' with '12300' under 'Identity'
    And I fill the 'text' field 'Channel Spacing (Hz)' with '13500' under 'Identity'
    And I press the button with 'Save' label
    Then I am in the 'configure/frequency-plan-status/4' page
    And I can see the 'Name' is 'EDIT_FP' under 'Identity' on the form
    And I can see the 'Frequency Plan ID' is '5' under 'Identity' on the form
    And I can see the 'Channel Type' is 'FDMA' under 'Identity' on the form
    And I can see the 'Base Frequency (Hz)' is '122,500,000' under 'Identity' on the form
    And I can see the 'Transmit Offset (Hz)' is '400,000' under 'Identity' on the form
    And I can see the 'Channel Bandwidth (Hz)' is '12,300' under 'Identity' on the form
    And I can see the 'Channel Spacing (Hz)' is '13,500' under 'Identity' on the form


  Scenario Outline: Edit a Frequency Plan form with invalid data
    Given There is '4' rows in the table
    When I select row '2' on the table
    And I press the button with 'Edit' label
    And I fill the 'text' field '<field_name>' with '<value>' under 'Identity'
    Then I see an error message '<error_msg>'
    And The button with 'Save' label is been disabled

    Examples:
      | field_name             | value       | error_msg                         |
      | Name                   | spa ce      | Illegal characters in input value |
      | Frequency Plan ID      | -1          | Invalid Value (1 ~ 16)            |
      | Frequency Plan ID      | 17          | Invalid Value (1 ~ 16)            |
      | Frequency Plan ID      | string      | Invalid value                     |
      | Base Frequency (Hz)    | -1          | Invalid Value (1 ~ 999999999)     |
      | Base Frequency (Hz)    | 1000000000  | Invalid Value (1 ~ 999999999)     |
      | Base Frequency (Hz)    | 999999999   | Number not divisible by 5         |
      | Base Frequency (Hz)    | string      | Invalid value                     |
      | Transmit Offset (Hz)   | -4          | Invalid Value (±5 ~ ±999999995)   |
      | Transmit Offset (Hz)   | 4           | Invalid Value (±5 ~ ±999999995)   |
      | Transmit Offset (Hz)   | -1000000000 | Invalid Value (±5 ~ ±999999995)   |
      | Transmit Offset (Hz)   | 1000000000  | Invalid Value (±5 ~ ±999999995)   |
      | Transmit Offset (Hz)   | 999999      | Number not divisible by 5         |
      | Transmit Offset (Hz)   | string      | Invalid value                     |
      | Channel Bandwidth (Hz) | 6249        | Invalid Value (6250 ~ 12500)      |
      | Channel Bandwidth (Hz) | 12501       | Invalid Value (6250 ~ 12500)      |
      | Channel Bandwidth (Hz) | string      | Invalid value                     |
      | Channel Spacing (Hz)   | 3124        | Invalid Value (3125 ~ 50000)      |
      | Channel Spacing (Hz)   | 50001       | Invalid Value (3125 ~ 50000)      |
      | Channel Spacing (Hz)   | 12503       | Number not divisible by 125       |
      | Channel Spacing (Hz)   | string      | Invalid value                     |


  Scenario Outline: Filter RFSS Manager Frequency Plan table
    Given There is at less '4' rows in the table
    When I input '<filter>' to the filter box
    Then There is '<left_user_count>' rows in the table

    Examples:
      | filter      | left_user_count |
      | Yes         | 4               |
      | FDMA        | 3               |
      | TDMA        | 2               |
      | EDIT_FP     | 1               |
      | random_test | 0               |


  Scenario Outline: Sort RFSS Manager Frequency Plan table with column <column>
    Given There is at less '4' rows in the table
    When I sort the table with '<column>' in ASC
    Then The '<column_type>' under the '<column>' is in 'ASC' order
    When I sort the table with '<column>' in DESC
    Then The '<column_type>' under the '<column>' is in 'DESC' order

    Examples:
      | column                    | column_type |
      | Name                      | string      |
      | Frequency Plan ID         | number      |
      | Channel Type              | string      |
      | Base Frequency (Hz)       | number      |
      | Transmit Offset (Hz)      | number      |
      | Channel Bandwidth (Hz)    | number      |
      | Channel Spacing (Hz)      | number      |
      | Channels In UHF/VHF Range | string      |


  Scenario: Delete a Frequency Plan
    Given There is '4' rows in the table
    When I select row '2' on the table
    And I press the button with 'Delete' label
    And I press the button with 'OK' label
    Then There is '3' rows in the table


  Scenario: Delete more then one Frequency Plan
    Given There is '3' rows in the table
    When I select row '1' on the table
    When I select row '2' on the table
    And I press the button with 'Delete Many' label
    And I press the button with 'OK' label
    Then There is '1' rows in the table