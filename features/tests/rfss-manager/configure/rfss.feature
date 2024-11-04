@WebUI @RFSS-Manager
@configure @empty
Feature: RFSS Manager - RFSS Form
  Test the RFSS Manager RFSS page

  Background: Opening the RFSS Manager RFSS page
    Given I opened the 'RFSS Manager'
    And I logged in as User: 'taitnet', Password: 'tait'
    When I select 'RFSS' from 'Configure' on navbar
    Then I am in the 'configure/rfss' page


  Scenario: Filling out the Identity section with valid data
    Given I press the button with 'Edit' label
    When I fill the 'text' field 'Name' with 'RFSS_Ubu' under 'Identity'
    And I fill the 'text' field 'IP Address' with '10.214.191.201' under 'Identity'
    And I fill the 'text' field 'Hostname' with 'RFSS-Ubu' under 'Identity'
    And I fill the 'text' field 'RFSS ID' with '7' under 'Identity'
    And I fill the 'text' field 'System ID' with '5' under 'Identity'
    And I fill the 'text' field 'WACN ID' with 'a4398' under 'Identity'
    And I press the button with 'Save' label
    Then I can see the 'Name' is 'RFSS_Ubu' under 'Identity'
    And I can see the 'IP Address' is '10.214.191.201' under 'Identity'
    And I can see the 'Hostname' is 'RFSS-Ubu' under 'Identity'
    And I can see the 'RFSS ID' is '7' under 'Identity'
    And I can see the 'System ID' is '5' under 'Identity'
    And I can see the 'WACN ID' is 'a4398' under 'Identity'


  Scenario Outline: Filling out the Identity section with invalid data
    Given I press the button with 'Edit' label
    When I fill the '<type>' field '<field_name>' with '<value>' under 'Identity'
    And I press the button with 'Save' label if it's not disable
    Then I see an error message '<error_msg>'

    Examples:
      | field_name | value   | type | error_msg                                                |
      | Name       |         | text | Empty value not allowed                                  |
      | Name       | spa ce  | text | Illegal characters in input value                        |
      | IP Address |         | text | Mismatch with RFSS Manager IP address in RFSS Controller |
      | IP Address | random  | text | Invalid IP format                                        |
      | Hostname   |         | text | Empty value not allowed                                  |
      | Hostname   | spa ce  | text | Illegal characters in input value                        |
      | RFSS ID    |         | text | Invalid Hex value                                        |
      | RFSS ID    | 0       | text | Invalid Value (1 ~ FE)                                   |
      | RFSS ID    | FF      | text | Invalid Value (1 ~ FE)                                   |
      | RFSS ID    | not_hex | text | Invalid Hex value                                        |
      | System ID  |         | text | Invalid Hex value                                        |
      | System ID  | 0       | text | Invalid Value (1 ~ FFE)                                  |
      | System ID  | FFF     | text | Invalid Value (1 ~ FFE)                                  |
      | System ID  | not_hex | text | Invalid Hex value                                        |
      | WACN ID    |         | text | Invalid Hex value                                        |
      | WACN ID    | 0       | text | Invalid Value (1 ~ FFFFE)                                |
      | WACN ID    | FFFFF   | text | Invalid Value (1 ~ FFFFE)                                |
      | WACN ID    | not_hex | text | Invalid Hex value                                        |


  Scenario: Pair info only show up when High Availability Enabled
    Given I can see the 'Enable High Availability' is 'No' under 'High Availability'
    When I press the button with 'Edit' label
    And There 'is no' 'text' field 'Controller A host name' under 'High Availability'
    And There 'is no' 'text' field 'Controller A IP Address' under 'High Availability'
    And There 'is no' 'text' field 'Controller B host name' under 'High Availability'
    And There 'is no' 'text' field 'Controller B IP Address' under 'High Availability'
    When I 'check' on the check box 'Enable High Availability' under 'High Availability' section
    Then There 'is' 'text' field 'Controller A host name' under 'High Availability'
    And There 'is' 'text' field 'Controller A IP Address' under 'High Availability'
    And There 'is' 'text' field 'Controller B host name' under 'High Availability'
    And There 'is' 'text' field 'Controller B IP Address' under 'High Availability'


  Scenario: Filling out the High Availability section with valid data
    Given I press the button with 'Edit' label
    When I 'check' on the check box 'Enable High Availability' under 'High Availability' section
    And I fill the 'text' field 'Controller A host name' with 'Pair-A' under 'High Availability'
    And I fill the 'text' field 'Controller A IP Address' with '127.0.1.1' under 'High Availability'
    And I fill the 'text' field 'Controller B host name' with 'Pair-B' under 'High Availability'
    And I fill the 'text' field 'Controller B IP Address' with '127.0.1.2' under 'High Availability'
    And I press the button with 'Save' label
    Then I can see the 'Enable High Availability' is 'Yes' under 'High Availability'
    And I can see the 'Controller A host name' is 'Pair-A' under 'High Availability'
    And I can see the 'Controller A IP Address' is '127.0.1.1' under 'High Availability'
    And I can see the 'Controller B host name' is 'Pair-B' under 'High Availability'
    And I can see the 'Controller B IP Address' is '127.0.1.2' under 'High Availability'


  Scenario: Filling out the pair info High Availability section with same ip
    Given I press the button with 'Edit' label
    When I fill the 'text' field 'Controller A IP Address' with '1.1.1.1' under 'High Availability'
    And I fill the 'text' field 'Controller B IP Address' with '1.1.1.1' under 'High Availability'
    And I press the button with 'Save' label
    Then I see an error message 'IP duplicate with Controller B IP address.'
    And I see an error message 'IP duplicate with Controller A IP address.'


  Scenario Outline: Filling out the High Availability section with invalid data
    Given I press the button with 'Edit' label
    When I fill the '<type>' field '<field_name>' with '<value>' under 'High Availability'
    And I press the button with 'Save' label if it's not disable
    Then I see an error message '<error_msg>'

    Examples:
      | field_name              | value  | type | error_msg         |
      | Controller A IP Address |        | text | Invalid Format    |
      | Controller A IP Address | random | text | Invalid IP format |
      | Controller B IP Address |        | text | Invalid Format    |
      | Controller B IP Address | random | text | Invalid IP format |


  Scenario: Filling out the General section with valid data
    Given I press the button with 'Edit' label
    When I 'check' on the check box 'Allow PSTN Calls' under 'General' section
    And I fill the 'number' field 'Registration Period' with '86401' under 'General'
    And I 'check' on the check box 'Extended call records' under 'General' section
    And I fill the 'number' field 'Channel partition priority threshold' with '2' under 'General'
    And I press the button with 'Save' label
    Then I can see the 'Allow PSTN Calls' is 'Yes' under 'General'
    And I can see the 'Registration Period' is '86,401 sec' under 'General'
    And I can see the 'Extended call records' is 'Yes' under 'General'
    And I can see the 'Channel partition priority threshold' is '2' under 'General'


  Scenario Outline: Filling out the General section with invalid data
    Given I press the button with 'Edit' label
    When I fill the '<type>' field '<field_name>' with '<value>' under 'General'
    And I press the button with 'Save' label if it's not disable
    Then I see an error message '<error_msg>'

    Examples:
      | field_name                           | value  | type   | error_msg                  |
      | Registration Period                  |        | number | Invalid Value (1 ~ 172800) |
      | Registration Period                  | 0      | number | Invalid Value (1 ~ 172800) |
      | Registration Period                  | 172801 | number | Invalid Value (1 ~ 172800) |
      | Channel partition priority threshold |        | number | Invalid Value (2 ~ 10)     |
      | Channel partition priority threshold | 1      | number | Invalid Value (2 ~ 10)     |
      | Channel partition priority threshold | 11     | number | Invalid Value (2 ~ 10)     |


  Scenario: Filling out the Dynamic Regroup section with valid data
    Given I press the button with 'Edit' label
    And I fill the 'number' field 'Maximum Number Of Supergroups' with '20' under 'Dynamic Regroup'
    And I fill the 'number' field 'Maximum Number Of Super Group Member Patched' with '5' under 'Dynamic Regroup'
    And I press the button with 'Save' label
    Then I can see the 'Maximum Number Of Supergroups' is '20' under 'Dynamic Regroup'
    And I can see the 'Maximum Number Of Super Group Member Patched' is '5' under 'Dynamic Regroup'


  Scenario Outline: Filling out the Dynamic Regroup section with invalid data
    Given I press the button with 'Edit' label
    When I fill the '<type>' field '<field_name>' with '<value>' under 'Dynamic Regroup'
    And I press the button with 'Save' label if it's not disable
    Then I see an error message '<error_msg>'

    Examples:
      | field_name                                   | value | type   | error_msg              |
      | Maximum Number Of Supergroups                |       | number | Invalid Format         |
      | Maximum Number Of Supergroups                | -1    | number | Invalid Value (0 ~ 50) |
      | Maximum Number Of Supergroups                | 51    | number | Invalid Value (0 ~ 50) |
      | Maximum Number Of Super Group Member Patched |       | number | Invalid Format         |
      | Maximum Number Of Super Group Member Patched | 1     | number | Invalid Value (2 ~ 10) |
      | Maximum Number Of Super Group Member Patched | 11    | number | Invalid Value (2 ~ 10) |


  Scenario: SNDCP Standby Time only show up when Packet Data Enabled
    Given I can see the 'Enable Packet Data' is 'No' under 'Packet Data'
    When I press the button with 'Edit' label
    And There 'is no' dropdown 'Sndcp Standby Time' under 'Packet Data'
    When I 'check' on the check box 'Enable Packet Data' under 'Packet Data' section
    Then There 'is' dropdown 'Sndcp Standby Time' under 'Packet Data'


  Scenario: Filling out the Packet Data section with valid data
    Given I press the button with 'Edit' label
    When I 'check' on the check box 'Enable Packet Data' under 'Packet Data' section
    And I choose '5 minutes' option from the 'Sndcp Standby Time' dropdown under 'Packet Data' section
    And I press the button with 'Save' label
    Then I can see the 'Enable Packet Data' is 'Yes' under 'Packet Data'
    And I can see the 'SNDCP Standby Time' is '5 minutes' under 'Packet Data'


  Scenario: Filling out the Data API Connector section with valid data
    Given I press the button with 'Edit' label
    When I 'check' on the check box 'Enable Data API' under 'Data API Connector' section
    And I fill the 'text' field 'IP Address' with '127.0.0.5' under 'Data API Connector'
    And I fill the 'number' field 'Port' with '5000' under 'Data API Connector'
    And I press the button with 'Save' label
    Then I can see the 'Enable Data API' is 'Yes' under 'Data API Connector'
    And I can see the 'IP Address' is '127.0.0.5' under 'Data API Connector'
    And I can see the 'Port' is '5,000' under 'Data API Connector'


  Scenario Outline: Filling out the Data API Connector section with invalid data
    Given I press the button with 'Edit' label
    When I fill the '<type>' field '<field_name>' with '<value>' under 'Data API Connector'
    And I press the button with 'Save' label if it's not disable
    Then I see an error message '<error_msg>'

    Examples:
      | field_name | value  | type   | error_msg                    |
      | IP Address |        | text   | Invalid Format               |
      | IP Address | random | text   | Invalid IP format            |
      | Port       |        | number | Invalid Format               |
      | Port       | 1022   | number | Invalid Value (1023 ~ 65535) |
      | Port       | 65536  | number | Invalid Value (1023 ~ 65535) |


  Scenario: Filling out the SNMP section with valid data
    Given I press the button with 'Edit' label
    And I fill the 'number' field 'Concurrent Call Limit Trap Threshold' with '10' under 'SNMP'
    And I fill the 'number' field 'Concurrent Call Legs Trap Threshold' with '10' under 'SNMP'
    And I fill the 'number' field 'Trap hold off period (seconds)' with '10' under 'SNMP'
    And I press the button with 'Save' label
    And I can see the 'Concurrent Call Limit Trap Threshold' is '10' under 'SNMP'
    And I can see the 'Concurrent Call Legs Trap Threshold' is '10' under 'SNMP'
    And I can see the 'Trap hold off period (seconds)' is '10' under 'SNMP'


  Scenario Outline: Filling out the SNMP section with invalid data
    Given I press the button with 'Edit' label
    When I fill the '<type>' field '<field_name>' with '<value>' under 'SNMP'
    And I press the button with 'Save' label if it's not disable
    Then I see an error message '<error_msg>'

    Examples:
      | field_name                           | value | type   | error_msg               |
      | Concurrent Call Limit Trap Threshold |       | number | Invalid Format          |
      | Concurrent Call Limit Trap Threshold | 0     | number | Invalid Value (1 ~ 99)  |
      | Concurrent Call Limit Trap Threshold | 100   | number | Invalid Value (1 ~ 99)  |
      | Concurrent Call Legs Trap Threshold  |       | number | Invalid Format          |
      | Concurrent Call Legs Trap Threshold  | 0     | number | Invalid Value (1 ~ 199) |
      | Concurrent Call Legs Trap Threshold  | 200   | number | Invalid Value (1 ~ 199) |
      | Trap hold off period (seconds)       |       | number | Invalid Format          |
      | Trap hold off period (seconds)       | 0     | number | Invalid Value (1 ~ 600) |
      | Trap hold off period (seconds)       | 601   | number | Invalid Value (1 ~ 600) |
