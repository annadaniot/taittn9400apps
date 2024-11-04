@WebUI @RFSS-Manager
@configure @empty
Feature: RFSS Manager - Local Profiles
  Test the RFSS Manager Local Profiles page

  Background: Opening the RFSS Manager Local Profiles page
    Given I opened the 'RFSS Manager'
    And I logged in as User: 'taitnet', Password: 'tait'
    When I select 'Local profile' from 'Profiles' on navbar
    Then I am in the 'configure/profiles/local' page


  Scenario: There is no edit button for the Default profile on table
    Given There is '1' rows in the table
    When I select row '0' on the table
    Then There is no 'Edit' button


  Scenario: Link to Local Profile View page
    Given There is '1' rows in the table
    When I click on the text in row '0' and column 'Name'
    Then I am in the 'configure/profiles/local/1' page


  Scenario: There is no edit button for the Default profile on detail page
    Given There is '1' rows in the table
    When I select row '0' on the table
    Then There is no 'Edit' button


  Scenario: There is undeleteable profile call Default
    Given There is '1' rows in the table
    When I select row '0' on the table
    And I press the button with 'Delete' label
    Then A dialog shown 'You cannot delete the default profile.' on the page


  Scenario: Creating a Local Profiles use button under table
    Given There is '1' rows in the table
    When I press the button with 'Create' label
    Then I am in the 'configure/profiles/local/create' page
    When I fill the 'text' field 'Profile name' with 'New_Local_Profile_1' under 'Identity'
    And I fill the 'number' field 'Group Regroup command broadcast interval (seconds)' with '3600' under 'Timers'
    And I fill the 'number' field 'Local registration time (seconds)' with '86400' under 'Timers'
    And I 'check' on the check box 'Allow group services' under 'Misc' section
    And I fill the 'number' field 'Local commanded registration limit per second' with '5' under 'Misc'
    And I 'check' on the check box 'Local forced registrations on exit site-trunking' under 'Misc' section
    And I press the button with 'Save' label
    Then There is '2' rows in the table


  Scenario: Copy a Local Profiles use button under table
    Given There is '2' rows in the table
    When I select row '0' on the table
    And I press the button with 'Copy' label
    Then I am in the 'configure/profiles/local/1/copy' page


  Scenario: Copy a Local Profiles use button under detail page
    Given There is '2' rows in the table
    When I click on the text in row '1' and column 'Name'
    Then I am in the 'configure/profiles/local/2' page
    When I press the button with 'Copy' label
    Then I am in the 'configure/profiles/local/2/copy' page
    When I fill the 'text' field 'Profile name' with 'New_Local_Profile_2' under 'Identity'
    And I fill the 'number' field 'Group Regroup command broadcast interval (seconds)' with '20' under 'Timers'
    And I fill the 'number' field 'Local registration time (seconds)' with '5' under 'Timers'
    And I 'uncheck' on the check box 'Allow group services' under 'Misc' section
    And I fill the 'number' field 'Local commanded registration limit per second' with '1' under 'Misc'
    And I 'uncheck' on the check box 'Local forced registrations on exit site-trunking' under 'Misc' section
    And I press the button with 'Save' label
    Then I am in the 'configure/profiles/local/2' page
    When I press the button with 'Back' label
    Then I am in the 'configure/profiles/local' page
    And There is '3' rows in the table


  Scenario: Edit a Local Profiles use button under table
    Given There is '3' rows in the table
    When I select row '1' on the table
    And I press the button with 'Edit' label
    Then I am in the 'configure/profiles/local/2/edit' page


  Scenario: Edit a Local Profiles use button under detail page
    Given There is '3' rows in the table
    When I click on the text in row '2' and column 'Name'
    Then I am in the 'configure/profiles/local/3' page
    When I press the button with 'Edit' label
    Then I am in the 'configure/profiles/local/3/edit' page
    When I fill the 'text' field 'Profile name' with 'New_Local_Profile_Edit' under 'Identity'
    And I fill the 'number' field 'Group Regroup command broadcast interval (seconds)' with '1810' under 'Timers'
    And I fill the 'number' field 'Local registration time (seconds)' with '43200' under 'Timers'
    And I 'check' on the check box 'Allow group services' under 'Misc' section
    And I fill the 'number' field 'Local commanded registration limit per second' with '3' under 'Misc'
    And I 'check' on the check box 'Local forced registrations on exit site-trunking' under 'Misc' section
    And I press the button with 'Save' label
    Then I am in the 'configure/profiles/local/3' page
    And I can see the 'Profile name' is 'New_Local_Profile_Edit' under 'Identity'
    And I can see the 'Group Regroup command broadcast interval (seconds)' is '1810' under 'Timers'
    And I can see the 'Local registration time (seconds)' is '43,200' under 'Timers'
    And I can see the 'Allow group services' is 'Yes' under 'Misc'
    And I can see the 'Local commanded registration limit per second' is '3' under 'Misc'
    And I can see the 'Local forced registrations on exit site-trunking' is 'Yes' under 'Misc'


  Scenario Outline: Edit a Local Profiles with invalid data
    Given There is '3' rows in the table
    When I click on the text in row '2' and column 'Name'
    Then I am in the 'configure/profiles/local/3' page
    When I press the button with 'Edit' label
    And I fill the '<type>' field '<field_name>' with '<value>' under '<section>'
    Then I see an error message '<error_msg>'
    And The button with 'Save' label is been disabled

    Examples:
      | field_name                                         | type   | section  | value  | error_msg                         |
      | Profile name                                       | text   | Identity |        | Empty value not allowed           |
      | Profile name                                       | text   | Identity | spa ce | Illegal characters in input value |
      | Group Regroup command broadcast interval (seconds) | number | Timers   | 19     | Invalid Value (20 ~ 3600)         |
      | Group Regroup command broadcast interval (seconds) | number | Timers   | 3601   | Invalid Value (20 ~ 3600)         |
      | Local registration time (seconds)                  | number | Timers   | 4      | Invalid Value (5 ~ 86400)         |
      | Local registration time (seconds)                  | number | Timers   | 86401  | Invalid Value (5 ~ 86400)         |
      | Local commanded registration limit per second      | number | Misc     | 0      | Invalid Value (1 ~ 5)             |
      | Local commanded registration limit per second      | number | Misc     | 6      | Invalid Value (1 ~ 5)             |


  Scenario Outline: Filter RFSS Manager Local Profiles table
    Given There is at less '3' rows in the table
    When I input '<filter>' to the filter box
    Then There is '<left_user_count>' rows in the table

    Examples:
      | filter      | left_user_count |
      | f           | 3               |
      | Local       | 2               |
      | Default     | 1               |
      | random_test | 0               |


  Scenario: Sort RFSS Manager Local Profiles table with column Name
    Given There is at less '3' rows in the table
    When I sort the table with 'Name' in ASC
    Then The 'string' under the 'Name' is in 'ASC' order
    When I sort the table with 'Name' in DESC
    Then The 'string' under the 'Name' is in 'DESC' order


  Scenario: Choose all Local Profiles from Site Page
    Given There is at less '3' rows in the table
    When I select section 'Sites' on navbar
    Then I am in the 'configure/sites' page
    When I press the button with 'Create' label
    Then I am in the 'configure/sites/add' page
    And There 'is' dropdown 'Local Profile' under 'Profiles'
    And There is '3' options in the dropdown 'Local Profile' under 'Profiles'


  Scenario: Delete more then one Local Profiles
    Given There is '3' rows in the table
    When I select row '1' on the table
    And I select row '2' on the table
    Then There is 'Delete Many' button


  Scenario: Delete a Local Profiles
    Given There is '3' rows in the table
    When I select row '2' on the table
    And I press the button with 'Delete' label
    And I press the button with 'OK' label
    Then There is '2' rows in the table
