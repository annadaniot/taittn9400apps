@WebUI @RFSS-Manager
@configure @empty
Feature: RFSS Manager - RFSS Agencies
    Test the RFSS Manager Agencies page

    Background: Opening the RFSS Manager Agencies page
        Given I opened the 'RFSS Manager'
        And I logged in as User: 'taitnet', Password: 'tait'
        When I select 'Agencies' from 'Configure' on navbar
        Then I am in the 'configure/agencies' page

    Scenario Outline: Creating a <type> Agencies
        Given There is '<row_before>' rows in the table
        When I press the button with 'Create' label
        Then I am in the 'configure/agencies/create' page
        When I fill the 'text' field 'Name' with '<name>' under 'Agency'
        And I fill the 'text' field 'Description' with '<description>' under 'Agency'
        When I press the button with 'Save' label
        Then There is '<row_after>' rows in the table

        Examples:
            | name         | description      | row_before | row_after |
            | one_agency   | The one agency   | 1          | 2         |
            | two_agency   | The two agency   | 2          | 3         |
            | three_agency | The three agency | 3          | 4         |

    Scenario: Can edit an agency
        Given Row '3' has 'three_agency' in column 'Agency'
        When I press the 'three_agency' text
        Then I am in the 'configure/agencies-status/4' page
        And I can see the text field, id:'Description' under 'Agency' has 'The three agency'
        When I press the button with 'Edit' label
        Then I am in the 'configure/agencies/4/edit' page
        When I fill the 'text' field 'Description' with 'The three agency update page' under 'Agency'
        Then I can see the input field 'Description' with 'The three agency update page' under 'Agency'
        When I press the button with 'Reset' label
        Then I can see the input field 'Description' with 'The three agency' under 'Agency'
        When I fill the 'text' field 'Description' with 'The three agency update page' under 'Agency'
        And I press the button with 'Save' label
        Then I am in the 'configure/agencies-status/4' page
        And I can see the text field, id:'Description' under 'Agency' has 'The three agency update page'
        When I press the button with 'Back' label
        Then Row '3' has 'The three agency update page' in column 'Description'

    # ##################### Bad cases #####################

    Scenario: Creating an agency with default name.
        Given Row '0' has 'Default' in column 'Agency'
        When I press the button with 'Create' label
        Then I am in the 'configure/agencies/create' page
        When I fill the 'text' field 'Name' with 'Default' under 'Agency'
        And I press the button with 'Save' label
        Then I am in the 'configure/agencies/create' page
        And I see an error message 'The entered name is either already present or not allowed'

    Scenario: Creating an agency with empty name.
        When I press the button with 'Create' label
        Then I am in the 'configure/agencies/create' page
        When I fill the 'text' field 'Name' with '' under 'Agency'
        Then I see an error message 'Empty value not allowed'

    Scenario: Creating an agency with very long name.
        When I press the button with 'Create' label
        Then I am in the 'configure/agencies/create' page
        When I fill the 'text' field 'Name' with 'a_51_letters_long_name_aaaaaaaaaaaaaaaaaaaaaaaaaaaa' under 'Agency'
        And I press the button with 'Save' label
        Then I see an error message 'String too long'

    Scenario: Creating an agency with very long description.
        When I press the button with 'Create' label
        Then I am in the 'configure/agencies/create' page
        When I fill the 'text' field 'Description' with 'This line is 129 characters long.################################################################################################' under 'Agency'
        And I fill the 'text' field 'Name' with 'abcdefg' under 'Agency'
        And I press the button with 'Save' label
        Then I see an error message 'String too long'
