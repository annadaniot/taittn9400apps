@WebUI @RFSS-Manager
@configure @empty
Feature: RFSS Manager - Call Profiles
  Test the RFSS Manager Call Profiles page

  Background: Opening the RFSS Manager Call Profiles page
    Given I opened the 'RFSS Manager'
    And I logged in as User: 'taitnet', Password: 'tait'
    When I select 'Call profile' from 'Profiles' on navbar
    Then I am in the 'configure/profiles/call' page


  Scenario: There is no edit button for the Default profile on table
    Given There is '1' rows in the table
    When I select row '0' on the table
    Then There is no 'Edit' button


  Scenario: Link to Call Profile View page
    Given There is '1' rows in the table
    When I click on the text in row '0' and column 'Name'
    Then I am in the 'configure/profiles/call/1' page


  Scenario: There is no edit button for the Default profile on detail page
    Given There is '1' rows in the table
    When I select row '0' on the table
    Then There is no 'Edit' button


  Scenario: There is undeleteable profile call Default
    Given There is '1' rows in the table
    When I select row '0' on the table
    And I press the button with 'Delete' label
    Then A dialog shown 'You cannot delete the default profile.' on the page


  Scenario: Creating a Call Profiles use button under table
    Given There is '1' rows in the table
    When I press the button with 'Create' label
    Then I am in the 'configure/profiles/call/create' page
    When I fill the 'text' field 'Profile name' with 'New_Call_Profile_1' under 'Identity'
    And I fill the 'number' field 'Unit call answer timeout (sec)' with '99' under 'Timers'
    And I fill the 'number' field 'Unit call inactivity timeout (ms)' with '30000' under 'Timers'
    And I fill the 'number' field 'Group' with '10' under 'Call priorities'
    And I fill the 'number' field 'Unit to unit' with '10' under 'Call priorities'
    And I fill the 'number' field 'PSTN' with '10' under 'Call priorities'
    And I fill the 'number' field 'Data' with '10' under 'Call priorities'
    And I fill the 'number' field 'Maximum queued call requests' with '99' under 'Misc'
    And I 'check' on the check box 'Sticky emergency group call' under 'Misc' section
    And I 'check' on the check box 'Allow normal group call while announcement call' under 'Misc' section
    And I 'check' on the check box 'Allow local call to continue when entering/exiting site-trunking' under 'Misc' section
    And I 'check' on the check box 'Allow local call after no RFSS response' under 'Misc' section
    And I 'check' on the check box 'Allow packet data while inhibited' under 'Misc' section
    And I press the button with 'Save' label
    Then There is '2' rows in the table


  Scenario: Copy a Call Profiles use button under table
    Given There is '2' rows in the table
    When I select row '0' on the table
    And I press the button with 'Copy' label
    Then I am in the 'configure/profiles/call/1/copy' page


  Scenario: Copy a Call Profiles use button under detail page
    Given There is '2' rows in the table
    When I click on the text in row '1' and column 'Name'
    Then I am in the 'configure/profiles/call/2' page
    When I press the button with 'Copy' label
    Then I am in the 'configure/profiles/call/2/copy' page
    When I fill the 'text' field 'Profile name' with 'New_Call_Profile_2' under 'Identity'
    And I fill the 'number' field 'Unit call answer timeout (sec)' with '0' under 'Timers'
    And I fill the 'number' field 'Unit call inactivity timeout (ms)' with '0' under 'Timers'
    And I fill the 'number' field 'Group' with '1' under 'Call priorities'
    And I fill the 'number' field 'Unit to unit' with '1' under 'Call priorities'
    And I fill the 'number' field 'PSTN' with '1' under 'Call priorities'
    And I fill the 'number' field 'Data' with '1' under 'Call priorities'
    And I fill the 'number' field 'Maximum queued call requests' with '0' under 'Misc'
    And I 'uncheck' on the check box 'Sticky emergency group call' under 'Misc' section
    And I 'uncheck' on the check box 'Allow normal group call while announcement call' under 'Misc' section
    And I 'uncheck' on the check box 'Allow local call to continue when entering/exiting site-trunking' under 'Misc' section
    And I 'uncheck' on the check box 'Allow local call after no RFSS response' under 'Misc' section
    And I 'uncheck' on the check box 'Allow packet data while inhibited' under 'Misc' section
    And I press the button with 'Save' label
    Then I am in the 'configure/profiles/call/2' page
    When I press the button with 'Back' label
    Then I am in the 'configure/profiles/call' page
    And There is '3' rows in the table


  Scenario: Edit a Call Profiles use button under table
    Given There is '3' rows in the table
    When I select row '1' on the table
    And I press the button with 'Edit' label
    Then I am in the 'configure/profiles/call/2/edit' page


  Scenario: Edit a Call Profiles use button under detail page
    Given There is '3' rows in the table
    When I click on the text in row '2' and column 'Name'
    Then I am in the 'configure/profiles/call/3' page
    When I press the button with 'Edit' label
    Then I am in the 'configure/profiles/call/3/edit' page
    When I fill the 'text' field 'Profile name' with 'New_Call_Profile_Edit' under 'Identity'
    And I fill the 'number' field 'Unit call answer timeout (sec)' with '50' under 'Timers'
    And I fill the 'number' field 'Unit call inactivity timeout (ms)' with '15000' under 'Timers'
    And I fill the 'number' field 'Group' with '4' under 'Call priorities'
    And I fill the 'number' field 'Unit to unit' with '5' under 'Call priorities'
    And I fill the 'number' field 'PSTN' with '6' under 'Call priorities'
    And I fill the 'number' field 'Data' with '7' under 'Call priorities'
    And I fill the 'number' field 'Maximum queued call requests' with '60' under 'Misc'
    And I 'check' on the check box 'Sticky emergency group call' under 'Misc' section
    And I 'uncheck' on the check box 'Allow normal group call while announcement call' under 'Misc' section
    And I 'check' on the check box 'Allow local call to continue when entering/exiting site-trunking' under 'Misc' section
    And I 'uncheck' on the check box 'Allow local call after no RFSS response' under 'Misc' section
    And I 'check' on the check box 'Allow packet data while inhibited' under 'Misc' section
    And I press the button with 'Save' label
    Then I am in the 'configure/profiles/call/3' page
    And I can see the 'Profile name' is 'New_Call_Profile_Edit' under 'Identity'
    And I can see the 'Unit call answer timeout (sec)' is '50' under 'Timers'
    And I can see the 'Unit call inactivity timeout (ms)' is '15000' under 'Timers'
    And I can see the 'Group' is '4' under 'Call priorities'
    And I can see the 'Unit to unit' is '5' under 'Call priorities'
    And I can see the 'PSTN' is '6' under 'Call priorities'
    And I can see the 'Data' is '7' under 'Call priorities'
    And I can see the 'Maximum queued call requests' is '60' under 'Misc'
    And I can see the 'Sticky emergency group call' is 'Yes' under 'Misc'
    And I can see the 'Allow normal group call while announcement call' is 'No' under 'Misc'
    And I can see the 'Allow local call to continue when entering/exiting site-trunking' is 'Yes' under 'Misc'
    And I can see the 'Allow local call after no RFSS response' is 'No' under 'Misc'
    And I can see the 'Allow packet data while inhibited' is 'Yes' under 'Misc'


  Scenario Outline: Edit a Call Profiles with invalid data
    Given There is '3' rows in the table
    When I click on the text in row '2' and column 'Name'
    Then I am in the 'configure/profiles/call/3' page
    When I press the button with 'Edit' label
    And I fill the '<type>' field '<field_name>' with '<value>' under '<section>'
    Then I see an error message '<error_msg>'
    And The button with 'Save' label is been disabled

    Examples:
      | field_name                        | type   | section         | value  | error_msg                         |
      | Profile name                      | text   | Identity        |        | Empty value not allowed           |
      | Profile name                      | text   | Identity        | spa ce | Illegal characters in input value |
      | Unit call answer timeout (sec)    | number | Timers          | -1     | Invalid Value (0 ~ 99)            |
      | Unit call answer timeout (sec)    | number | Timers          | 100    | Invalid Value (0 ~ 99)            |
      | Unit call inactivity timeout (ms) | number | Timers          | -1     | Invalid Value (0 ~ 30000)         |
      | Unit call inactivity timeout (ms) | number | Timers          | 30001  | Invalid Value (0 ~ 30000)         |
      | Group                             | number | Call priorities | 0      | Invalid Value (1 ~ 10)            |
      | Group                             | number | Call priorities | 11     | Invalid Value (1 ~ 10)            |
      | Unit to unit                      | number | Call priorities | 0      | Invalid Value (1 ~ 10)            |
      | Unit to unit                      | number | Call priorities | 11     | Invalid Value (1 ~ 10)            |
      | PSTN                              | number | Call priorities | 0      | Invalid Value (1 ~ 10)            |
      | PSTN                              | number | Call priorities | 11     | Invalid Value (1 ~ 10)            |
      | Data                              | number | Call priorities | 0      | Invalid Value (1 ~ 10)            |
      | Data                              | number | Call priorities | 11     | Invalid Value (1 ~ 10)            |
      | Maximum queued call requests      | number | Misc            | -1     | Invalid Value (0 ~ 99)            |
      | Maximum queued call requests      | number | Misc            | 100    | Invalid Value (0 ~ 99)            |


  Scenario Outline: Filter RFSS Manager Call Profiles table
    Given There is at less '3' rows in the table
    When I input '<filter>' to the filter box
    Then There is '<left_user_count>' rows in the table

    Examples:
      | filter      | left_user_count |
      | f           | 3               |
      | Call        | 2               |
      | Default     | 1               |
      | random_test | 0               |


  Scenario: Sort RFSS Manager Call Profiles table with column Name
    Given There is at less '3' rows in the table
    When I sort the table with 'Name' in ASC
    Then The 'string' under the 'Name' is in 'ASC' order
    When I sort the table with 'Name' in DESC
    Then The 'string' under the 'Name' is in 'DESC' order


  Scenario: Choose all Call Profiles from Site Page
    Given There is at less '3' rows in the table
    When I select section 'Sites' on navbar
    Then I am in the 'configure/sites' page
    When I press the button with 'Create' label
    Then I am in the 'configure/sites/add' page
    And There 'is' dropdown 'Call Profile' under 'Profiles'
    And There is '3' options in the dropdown 'Call Profile' under 'Profiles'


  Scenario: Delete more then one Call Profiles
    Given There is '3' rows in the table
    When I select row '1' on the table
    And I select row '2' on the table
    Then There is 'Delete Many' button


  Scenario: Delete a Call Profiles
    Given There is '3' rows in the table
    When I select row '2' on the table
    And I press the button with 'Delete' label
    And I press the button with 'OK' label
    Then There is '2' rows in the table
