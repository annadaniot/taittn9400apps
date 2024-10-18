@WebUI @RFSS-Manager
@configure @empty
Feature: RFSS Manager - RFSS Agencies
    Fills out the RFSS Manager Agencies page

    Background: Opening the RFSS Manager
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
            | name          |   description         | row_before | row_after    |
            | one_agency    |   The one agency      |   1        |  2           |
            | two_agency    |   The two agency      |   2        |  3           |
            | three_agency  |   The three agency    |   3        |  4           |

    
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

