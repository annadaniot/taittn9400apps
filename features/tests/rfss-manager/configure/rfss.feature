@WebUI @RFSS-Manager
@configure @empty
Feature: RFSS Manager - RFSS Form
  Fills out the RFSS Manager RFSS page

  Background: Opening the RFSS Manager
    Given I opened the 'RFSS Manager'
    And I logged in as User: 'taitnet', Password: 'tait'
    When I select 'RFSS' from 'Configure' on navbar
    Then I am in the 'configure/rfss' page


  Scenario: Filling out the RFSS form with valid data
    Given I press the button with 'Edit' label
    When I fill the 'text' field 'Name' with 'RFSS_Ubu' under 'Identity'
    And I fill the 'text' field 'IP Address' with '10.214.191.201' under 'Identity'
    And I fill the 'text' field 'Hostname' with 'RFSS-Ubu' under 'Identity'
    And I fill the 'text' field 'RFSS ID' with '7' under 'Identity'
    And I fill the 'text' field 'System ID' with '5' under 'Identity'
    And I fill the 'text' field 'WACN ID' with 'a4398' under 'Identity'
    Then I press the button with 'Save' label


  Scenario Outline: Filling out the RFSS form Identity section with invalid data
    Given I press the button with 'Edit' label
    When I fill the '<type>' field '<field_name>' with '<value>' under 'Identity'
    Then I see an error message '<error_msg>'

    Examples:
      | field_name | value   | type | error_msg                         |
      | Name       | spa ce  | text | Illegal characters in input value |
      | IP Address | random  | text | Invalid IP format                 |
      | Hostname   | spa ce  | text | Illegal characters in input value |
      | RFSS ID    | 0       | text | Invalid Value (1 ~ FE)            |
      | RFSS ID    | FF      | text | Invalid Value (1 ~ FE)            |
      | RFSS ID    | not_hex | text | Invalid Hex value                 |
      | System ID  | 0       | text | Invalid Value (1 ~ FFE)           |
      | System ID  | FFF     | text | Invalid Value (1 ~ FFE)           |
      | System ID  | not_hex | text | Invalid Hex value                 |
      | WACN ID    | 0       | text | Invalid Value (1 ~ FFFFE)         |
      | WACN ID    | FFFFF   | text | Invalid Value (1 ~ FFFFE)         |
      | WACN ID    | not_hex | text | Invalid Hex value                 |
