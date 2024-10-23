@WebUI @RFSS-Manager
@configure @empty
Feature: RFSS Manager - Fleet Manager Form
  Fills out the RFSS Manager Fleet Manager page

  Background: Opening the RFSS Manager
    Given I opened the 'RFSS Manager'
    And I logged in as User: 'taitnet', Password: 'tait'
    When I select 'Fleet Manager' from 'Configure' on navbar
    Then I am in the 'configure/fleet-manager' page


  Scenario: Filling out the Fleet Manager form with valid data
    Given I press the button with 'Edit' label
    When I fill the 'text' field 'Name' with 'Ubu-RLR' under 'Identity'
    And I fill the 'text' field 'IP Address' with '10.214.191.202' under 'Identity'
    And I fill the 'text' field 'Hostname' with 'RLR-Ubu' under 'Identity'
    And I fill the 'text' field 'Site ID' with 'fe' under 'Identity'
    And I fill the 'text' field 'SUID' with 'fe' under 'Identity'
    Then I press the button with 'Save' label


  Scenario Outline: Filling out the Fleet Manager form Identity section with invalid data
    Given I press the button with 'Edit' label
    When I fill the '<type>' field '<field_name>' with '<value>' under 'Identity'
    Then I see an error message '<error_msg>'

    Examples:
      | field_name | value   | type | error_msg                         |
      | Name       |         | text | Empty value not allowed           |
      | Name       | spa ce  | text | Illegal characters in input value |
      | IP Address | random  | text | Invalid IP format                 |
      | Hostname   | spa ce  | text | Illegal characters in input value |
      | Site ID    |         | text | Invalid Hex value                 |
      | Site ID    | 0       | text | Invalid Value (1 ~ FE)            |
      | Site ID    | FF      | text | Invalid Value (1 ~ FE)            |
      | Site ID    | not_hex | text | Invalid Hex value                 |
      | SUID       |         | text | Invalid Hex value                 |
      | SUID       | 0       | text | Invalid Value (1 ~ FFFFFF)        |
      | SUID       | 1000000 | text | Invalid Value (1 ~ FFFFFF)        |
      | SUID       | not_hex | text | Invalid Hex value                 |
