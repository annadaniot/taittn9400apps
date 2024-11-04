@WebUI @RFSS-Manager
@configure @empty
Feature: RFSS Manager - Call Records Profiles
  Test the RFSS Manager Call Records Profiles page

  Background: Opening the RFSS Manager Call Records Profiles page
    Given I opened the 'RFSS Manager'
    And I logged in as User: 'taitnet', Password: 'tait'
    When I select 'Call records profile' from 'Profiles' on navbar
    Then I am in the 'configure/profiles/call-record' page


  Scenario: There is no edit button for the Default profile on table
    Given There is '1' rows in the table
    When I select row '0' on the table
    Then There is no 'Edit' button


  Scenario: Link to Call Records Profile View page
    Given There is '1' rows in the table
    When I click on the text in row '0' and column 'Name'
    Then I am in the 'configure/profiles/call-record/1' page


  Scenario: There is no edit button for the Default profile on detail page
    Given There is '1' rows in the table
    When I select row '0' on the table
    Then There is no 'Edit' button


  Scenario: There is undeleteable profile call Default
    Given There is '1' rows in the table
    When I select row '0' on the table
    And I press the button with 'Delete' label
    Then A dialog shown 'You cannot delete the default profile.' on the page


  Scenario: Creating a Call Records Profiles use button under table
    Given There is '1' rows in the table
    When I press the button with 'Create' label
    Then I am in the 'configure/profiles/call-record/create' page
    When I fill the 'text' field 'Profile name' with 'New_Call_Records_Profile_1' under 'Identity'
    And I 'check' on the check box 'Enable packet data transaction records' under 'Identity' section
    And I press the button with 'Save' label
    Then There is '2' rows in the table


  Scenario: Copy a Call Records Profiles use button under table
    Given There is '2' rows in the table
    When I select row '0' on the table
    And I press the button with 'Copy' label
    Then I am in the 'configure/profiles/call-record/1/copy' page


  Scenario: Copy a Call Records Profiles use button under detail page
    Given There is '2' rows in the table
    When I click on the text in row '1' and column 'Name'
    Then I am in the 'configure/profiles/call-record/2' page
    When I press the button with 'Copy' label
    Then I am in the 'configure/profiles/call-record/2/copy' page
    When I fill the 'text' field 'Profile name' with 'New_Call_Records_Profile_2' under 'Identity'
    And I 'uncheck' on the check box 'Enable packet data transaction records' under 'Identity' section
    And I press the button with 'Save' label
    Then I am in the 'configure/profiles/call-record/2' page
    When I press the button with 'Back' label
    Then I am in the 'configure/profiles/call-record' page
    And There is '3' rows in the table


  Scenario: Edit a Call Records Profiles use button under table
    Given There is '3' rows in the table
    When I select row '1' on the table
    And I press the button with 'Edit' label
    Then I am in the 'configure/profiles/call-record/2/edit' page


  Scenario: Edit a Call Records Profiles use button under detail page
    Given There is '3' rows in the table
    When I click on the text in row '2' and column 'Name'
    Then I am in the 'configure/profiles/call-record/3' page
    # Update after CNP25-4268
    And I can see the 'Enable packet data transaction records' is 'No'
    When I press the button with 'Edit' label
    Then I am in the 'configure/profiles/call-record/3/edit' page
    When I fill the 'text' field 'Profile name' with 'New_Call_Records_Profile_Edit' under 'Identity'
    And I 'check' on the check box 'Enable packet data transaction records' under 'Identity' section
    And I press the button with 'Save' label
    Then I am in the 'configure/profiles/call-record/3' page
    # Update after CNP25-4268
    And I can see the 'Profile name' is 'New_Call_Records_Profile_Edit'
    # Update after CNP25-4268
    And I can see the 'Enable packet data transaction records' is 'Yes'


  Scenario Outline: Edit a Call Records Profiles with invalid data
    Given There is '3' rows in the table
    When I click on the text in row '2' and column 'Name'
    Then I am in the 'configure/profiles/call-record/3' page
    When I press the button with 'Edit' label
    And I fill the '<type>' field '<field_name>' with '<value>' under '<section>'
    Then I see an error message '<error_msg>'
    And The button with 'Save' label is been disabled

    Examples:
      | field_name   | type | section  | value  | error_msg                         |
      | Profile name | text | Identity |        | Empty value not allowed           |
      | Profile name | text | Identity | spa ce | Illegal characters in input value |


  Scenario Outline: Filter RFSS Manager Call Records Profiles table
    Given There is at less '3' rows in the table
    When I input '<filter>' to the filter box
    Then There is '<left_user_count>' rows in the table

    Examples:
      | filter       | left_user_count |
      | f            | 3               |
      | Call_Records | 2               |
      | Default      | 1               |
      | random_test  | 0               |


  Scenario: Sort RFSS Manager Call Records Profiles table with column Name
    Given There is at less '3' rows in the table
    When I sort the table with 'Name' in ASC
    Then The 'string' under the 'Name' is in 'ASC' order
    When I sort the table with 'Name' in DESC
    Then The 'string' under the 'Name' is in 'DESC' order


  Scenario: Choose all Call Records Profiles from Site Page
    Given There is at less '3' rows in the table
    When I select section 'Sites' on navbar
    Then I am in the 'configure/sites' page
    When I press the button with 'Create' label
    Then I am in the 'configure/sites/add' page
    And There 'is' dropdown 'Event Profile' under 'Profiles'
    And There is '3' options in the dropdown 'Event Profile' under 'Profiles'


  Scenario: Delete more then one Call Records Profiles
    Given There is '3' rows in the table
    When I select row '1' on the table
    And I select row '2' on the table
    Then There is 'Delete Many' button


  Scenario: Delete a Call Records Profiles
    Given There is '3' rows in the table
    When I select row '2' on the table
    And I press the button with 'Delete' label
    And I press the button with 'OK' label
    Then There is '2' rows in the table
