@WebUI @RFSS-Manager
@configure @empty
Feature: RFSS Manager - NIF Profiles
  Test the RFSS Manager NIF Profiles page

  Background: Opening the RFSS Manager NIF Profiles page
    Given I opened the 'RFSS Manager'
    And I logged in as User: 'taitnet', Password: 'tait'
    When I select 'NIF profile' from 'Profiles' on navbar
    Then I am in the 'configure/profiles/nif' page


  Scenario: There is no edit button for the Default profile on table
    Given There is '1' rows in the table
    When I select row '0' on the table
    Then There is no 'Edit' button


  Scenario: Link to NIF Profile View page
    Given There is '1' rows in the table
    When I click on the text in row '0' and column 'Name'
    Then I am in the 'configure/profiles/nif/1' page


  Scenario: There is no edit button for the Default profile on detail page
    Given There is '1' rows in the table
    When I select row '0' on the table
    Then There is no 'Edit' button


  Scenario: There is undeleteable profile call Default
    Given There is '1' rows in the table
    When I select row '0' on the table
    And I press the button with 'Delete' label
    Then A dialog shown 'You cannot delete the default profile.' on the page


  Scenario: Creating a NIF Profiles use button under table
    Given There is '1' rows in the table
    When I press the button with 'Create' label
    Then I am in the 'configure/profiles/nif/create' page
    When I fill the 'text' field 'Profile name' with 'New_NIF_Profile_1' under 'Identity'
    And I fill the 'number' field 'Network check period while down' with '60' under 'Network status'
    And I fill the 'number' field 'Network check period before up' with '99' under 'Network status'
    And I fill the 'number' field 'Network check misses before down' with '99' under 'Network status'
    And I fill the 'number' field 'Network check period while up' with '60' under 'Network status'
    And I fill the 'number' field 'DSCP SIP' with '63' under 'QOS'
    And I fill the 'number' field 'DSCP RTP' with '63' under 'QOS'
    # TODO: change after CNP25-4264 solved
    # And I fill the 'number' field 'License expiry days remaining for notification (day)' with '4294967295' under 'SNMP'
    And I fill the 'number' field 'License expiry days remaining for notification (day)' with '294967295' under 'SNMP'
    And I fill the 'number' field 'Downlink TSBK threshold per second (block)' with '100' under 'SNMP'
    And I fill the 'number' field 'Uplink TSBK threshold per second (block)' with '100' under 'SNMP'
    And I press the button with 'Save' label
    Then There is '2' rows in the table


  Scenario: Copy a NIF Profiles use button under table
    Given There is '2' rows in the table
    When I select row '0' on the table
    And I press the button with 'Copy' label
    Then I am in the 'configure/profiles/nif/1/copy' page


  Scenario: Copy a NIF Profiles use button under detail page
    Given There is '2' rows in the table
    When I click on the text in row '1' and column 'Name'
    Then I am in the 'configure/profiles/nif/2' page
    When I press the button with 'Copy' label
    Then I am in the 'configure/profiles/nif/2/copy' page
    When I fill the 'text' field 'Profile name' with 'New_NIF_Profile_2' under 'Identity'
    And I fill the 'number' field 'Network check period while down' with '0' under 'Network status'
    And I fill the 'number' field 'Network check period before up' with '0' under 'Network status'
    And I fill the 'number' field 'Network check misses before down' with '0' under 'Network status'
    And I fill the 'number' field 'Network check period while up' with '0' under 'Network status'
    And I fill the 'number' field 'DSCP SIP' with '0' under 'QOS'
    And I fill the 'number' field 'DSCP RTP' with '0' under 'QOS'
    And I fill the 'number' field 'License expiry days remaining for notification (day)' with '0' under 'SNMP'
    And I fill the 'number' field 'Downlink TSBK threshold per second (block)' with '0' under 'SNMP'
    And I fill the 'number' field 'Uplink TSBK threshold per second (block)' with '0' under 'SNMP'
    And I press the button with 'Save' label
    Then I am in the 'configure/profiles/nif/2' page
    When I press the button with 'Back' label
    Then I am in the 'configure/profiles/nif' page
    And There is '3' rows in the table


  Scenario: Edit a NIF Profiles use button under table
    Given There is '3' rows in the table
    When I select row '1' on the table
    And I press the button with 'Edit' label
    Then I am in the 'configure/profiles/nif/2/edit' page


  Scenario: Edit a NIF Profiles use button under detail page
    Given There is '3' rows in the table
    When I click on the text in row '2' and column 'Name'
    Then I am in the 'configure/profiles/nif/3' page
    When I press the button with 'Edit' label
    Then I am in the 'configure/profiles/nif/3/edit' page
    When I fill the 'text' field 'Profile name' with 'New_NIF_Profile_Edit' under 'Identity'
    And I fill the 'number' field 'Network check period while down' with '30' under 'Network status'
    And I fill the 'number' field 'Network check period before up' with '50' under 'Network status'
    And I fill the 'number' field 'Network check misses before down' with '50' under 'Network status'
    And I fill the 'number' field 'Network check period while up' with '30' under 'Network status'
    And I fill the 'number' field 'DSCP SIP' with '31' under 'QOS'
    And I fill the 'number' field 'DSCP RTP' with '31' under 'QOS'
    And I fill the 'number' field 'License expiry days remaining for notification (day)' with '42949' under 'SNMP'
    And I fill the 'number' field 'Downlink TSBK threshold per second (block)' with '50' under 'SNMP'
    And I fill the 'number' field 'Uplink TSBK threshold per second (block)' with '50' under 'SNMP'
    And I press the button with 'Save' label
    Then I am in the 'configure/profiles/nif/3' page
    And I can see the 'Profile name' is 'New_NIF_Profile_Edit' under 'Identity'
    And I can see the 'Network check period while down' is '30' under 'Network status'
    And I can see the 'Network check period before up' is '50' under 'Network status'
    And I can see the 'Network check misses before down' is '50' under 'Network status'
    And I can see the 'Network check period while up' is '30' under 'Network status'
    And I can see the 'DSCP SIP' is '31' under 'QOS'
    And I can see the 'DSCP RTP' is '31' under 'QOS'
    And I can see the 'Enable SNMP' is 'Yes' under 'SNMP'
    And I can see the 'License expiry days remaining for notification (day)' is '42949' under 'SNMP'
    And I can see the 'Downlink TSBK threshold per second (block)' is '50' under 'SNMP'
    And I can see the 'Uplink TSBK threshold per second (block)' is '50' under 'SNMP'


  Scenario Outline: Edit a NIF Profiles with invalid data
    Given There is '3' rows in the table
    When I click on the text in row '2' and column 'Name'
    Then I am in the 'configure/profiles/nif/3' page
    When I press the button with 'Edit' label
    And I fill the '<type>' field '<field_name>' with '<value>' under '<section>'
    Then I see an error message '<error_msg>'
    And The button with 'Save' label is been disabled

    Examples:
      | field_name                                 | type   | section        | value  | error_msg                         |
      | Profile name                               | text   | Identity       |        | Empty value not allowed           |
      | Profile name                               | text   | Identity       | spa ce | Illegal characters in input value |
      | Network check period while down            | number | Network status | -1     | Invalid Value (0 ~ 60)            |
      | Network check period while down            | number | Network status | 61     | Invalid Value (0 ~ 60)            |
      | Network check period before up             | number | Network status | -1     | Invalid Value (0 ~ 99)            |
      | Network check period before up             | number | Network status | 100    | Invalid Value (0 ~ 99)            |
      | Network check misses before down           | number | Network status | -1     | Invalid Value (0 ~ 99)            |
      | Network check misses before down           | number | Network status | 100    | Invalid Value (0 ~ 99)            |
      | Network check period while up              | number | Network status | -1     | Invalid Value (0 ~ 60)            |
      | Network check period while up              | number | Network status | 61     | Invalid Value (0 ~ 60)            |
      | DSCP SIP                                   | number | QOS            | -1     | Invalid Value (0 ~ 63)            |
      | DSCP SIP                                   | number | QOS            | 64     | Invalid Value (0 ~ 63)            |
      | DSCP RTP                                   | number | QOS            | -1     | Invalid Value (0 ~ 63)            |
      | DSCP RTP                                   | number | QOS            | 64     | Invalid Value (0 ~ 63)            |
      # TODO: enable after CNP25-4264 3.34 /*
      # | License expiry days remaining for notification (day) | number | SNMP           | -1     | Invalid Value (0 ~ 86400)         |
      # | License expiry days remaining for notification (day) | number | SNMP           | 86401  | Invalid Value (0 ~ 86400)         |
      # TODO: enable after CNP25-4264 3.34 */
      | Downlink TSBK threshold per second (block) | number | SNMP           | -1     | Invalid Value (0 ~ 100)           |
      | Downlink TSBK threshold per second (block) | number | SNMP           | 101    | Invalid Value (0 ~ 100)           |
      | Uplink TSBK threshold per second (block)   | number | SNMP           | -1     | Invalid Value (0 ~ 100)           |
      | Uplink TSBK threshold per second (block)   | number | SNMP           | 101    | Invalid Value (0 ~ 100)           |


  Scenario: SNMP detail only show up when SNMP enabled
    Given There is '3' rows in the table
    When I select row '1' on the table
    And I press the button with 'Edit' label
    Then I am in the 'configure/profiles/nif/2/edit' page
    And There 'is' 'number' field 'License expiry days remaining for notification (day)' under 'SNMP'
    And There 'is' 'number' field 'Downlink TSBK threshold per second (block)' under 'SNMP'
    And There 'is' 'number' field 'Uplink TSBK threshold per second (block)' under 'SNMP'
    When I 'uncheck' on the check box 'Enable SNMP' under 'SNMP' section
    Then There 'is no' 'number' field 'License expiry days remaining for notification (day)' under 'SNMP'
    And There 'is no' 'number' field 'Downlink TSBK threshold per second (block)' under 'SNMP'
    And There 'is no' 'number' field 'Uplink TSBK threshold per second (block)' under 'SNMP'


  Scenario Outline: Filter RFSS Manager NIF Profiles table
    Given There is at less '3' rows in the table
    When I input '<filter>' to the filter box
    Then There is '<left_user_count>' rows in the table

    Examples:
      | filter      | left_user_count |
      | f           | 3               |
      | NIF         | 2               |
      | Default     | 1               |
      | random_test | 0               |


  Scenario: Sort RFSS Manager NIF Profiles table with column Name
    Given There is at less '3' rows in the table
    When I sort the table with 'Name' in ASC
    Then The 'string' under the 'Name' is in 'ASC' order
    When I sort the table with 'Name' in DESC
    Then The 'string' under the 'Name' is in 'DESC' order


  Scenario Outline: Choose all NIF Profiles from <page_name> Page
    Given There is at less '3' rows in the table
    When I select '<page_name>' from 'Configure' on navbar
    And I press the button with 'Edit' label
    Then I am in the '<url>' page
    And There 'is' dropdown 'Nif Profile' under 'Profiles'
    And There is '3' options in the dropdown 'Nif Profile' under 'Profiles'

    Examples:
      | page_name     | url                          |
      | RFSS          | configure/rfss/edit          |
      | Fleet Manager | configure/fleet-manager/edit |
      | PSTN Gateway  | configure/pstn-gateway/edit  |


  Scenario: Choose all NIF from Site Page
    Given There is at less '3' rows in the table
    When I select section 'Sites' on navbar
    Then I am in the 'configure/sites' page
    When I press the button with 'Create' label
    Then I am in the 'configure/sites/add' page
    And There 'is' dropdown 'Nif Profile' under 'Profiles'
    And There is '3' options in the dropdown 'Nif Profile' under 'Profiles'


  Scenario: Delete more then one NIF Profiles
    Given There is '3' rows in the table
    When I select row '1' on the table
    And I select row '2' on the table
    Then There is 'Delete Many' button


  Scenario: Delete a NIF Profiles
    Given There is '3' rows in the table
    When I select row '2' on the table
    And I press the button with 'Delete' label
    And I press the button with 'OK' label
    Then There is '2' rows in the table
