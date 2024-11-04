@WebUI @RFSS-Manager
@configure @empty
Feature: RFSS Manager - PSTN Gateway Form
  Test the RFSS Manager PSTN Gateway page

  Background: Opening the RFSS Manager PSTN Gateway page
    Given I opened the 'RFSS Manager'
    And I logged in as User: 'taitnet', Password: 'tait'
    When I select 'PSTN Gateway' from 'Configure' on navbar
    Then I am in the 'configure/pstn-gateway' page


  Scenario: Filling out the PSTN Gateway form with valid data
    Given I press the button with 'Edit' label
    When I fill the 'text' field 'Name' with 'Ubu-PSTNG' under 'Identity'
    And I fill the 'text' field 'IP Address' with '10.214.191.205' under 'Identity'
    And I fill the 'text' field 'Hostname' with 'PSTNG-Ubu' under 'Identity'
    And I fill the 'text' field 'Site ID' with 'fd' under 'Identity'
    And I fill the 'text' field 'Router IP Address' with '0.0.0.0' under 'Identity'
    Then I press the button with 'Save' label
    And I can see the 'Name' is 'Ubu-PSTNG' under 'Identity'
    And I can see the 'IP Address' is '10.214.191.205' under 'Identity'
    And I can see the 'Hostname' is 'PSTNG-Ubu' under 'Identity'
    And I can see the 'Site ID' is 'fd' under 'Identity'
    And I can see the 'Router IP Address' is '0.0.0.0' under 'Identity'


  Scenario Outline: Filling out the PSTN Gateway form Identity section with invalid data
    Given I press the button with 'Edit' label
    When I fill the '<type>' field '<field_name>' with '<value>' under 'Identity'
    Then I see an error message '<error_msg>'

    Examples:
      | field_name        | value   | type | error_msg                         |
      | Name              |         | text | Empty value not allowed           |
      | Name              | spa ce  | text | Illegal characters in input value |
      | IP Address        | random  | text | Invalid IP format                 |
      | Hostname          | spa ce  | text | Illegal characters in input value |
      | Site ID           | 0       | text | Invalid Value (1 ~ FE)            |
      | Site ID           | FF      | text | Invalid Value (1 ~ FE)            |
      | Site ID           | not_hex | text | Invalid Hex value                 |
      | Router IP Address | random  | text | Invalid IP format                 |


  Scenario: Filling out General section on PSTN Gateway form with valid data
    Given I press the button with 'Edit' label
    When I fill the 'text' field 'Max Group Call Duration' with '100' under 'General'
    And I fill the 'text' field 'Max Unit Call Duration' with '90' under 'General'
    And I fill the 'text' field 'Network Connecting Timeout' with '80' under 'General'
    And I 'check' on the check box 'Use PCM U-law' under 'General' section
    Then I press the button with 'Save' label
    And I can see the 'Max Group Call Duration' is '100 sec' under 'General'
    And I can see the 'Max Unit Call Duration' is '90 sec' under 'General'
    And I can see the 'Network Connecting Timeout' is '80 sec' under 'General'
    And I can see the 'Use PCM U-law' is 'Yes' under 'General'


  Scenario Outline: Filling out General section on PSTN Gateway form with invalid data
    Given I press the button with 'Edit' label
    When I fill the '<type>' field '<field_name>' with '<value>' under 'General'
    Then I see an error message '<error_msg>'

    Examples:
      | field_name                 | value  | type | error_msg               |
      | Max Group Call Duration    |        | text | Invalid value           |
      | Max Group Call Duration    | random | text | Invalid value           |
      | Max Group Call Duration    | -1     | text | Invalid Value (0 ~ 999) |
      | Max Group Call Duration    | 1000   | text | Invalid Value (0 ~ 999) |
      | Max Unit Call Duration     |        | text | Invalid value           |
      | Max Unit Call Duration     | random | text | Invalid value           |
      | Max Unit Call Duration     | -1     | text | Invalid Value (0 ~ 999) |
      | Max Unit Call Duration     | 1000   | text | Invalid Value (0 ~ 999) |
      | Network Connecting Timeout |        | text | Invalid value           |
      | Network Connecting Timeout | random | text | Invalid value           |
      | Network Connecting Timeout | -1     | text | Invalid Value (0 ~ 999) |
      | Network Connecting Timeout | 1000   | text | Invalid Value (0 ~ 999) |
