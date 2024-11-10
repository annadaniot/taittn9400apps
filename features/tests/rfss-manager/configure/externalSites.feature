@WebUI @RFSS-Manager
@configure @external-device
Feature: RFSS Manager - RFSS External Sites
  Test the RFSS Manager External Sites page

  Background: Opening the RFSS Manager External Sites page
    Given I opened the 'RFSS Manager'
    And I logged in as User: 'taitnet', Password: 'tait'
    When I select 'External Sites' from 'Configure' on navbar
    Then I am in the 'configure/external-sites' page


  Scenario: Creating a External Sites
    Given There is '0' rows in the table
    When I press the button with 'Create' label
    Then I am in the 'configure/external-sites/create' page
    When I fill the 'text' field 'Name' with 'External_Sites_1' under 'Identity'
    And I choose 'Auckland' option from the 'External Device' dropdown under 'Identity' section
    And I fill the 'text' field 'Site ID' with '1' under 'Identity'
    And I press the button with 'Save' label
    Then There is '1' rows in the table


  Scenario: Creating a External Sites use Copy under table
    Given There is '1' rows in the table
    When I select row '0' on the table
    And I press the button with 'Copy' label
    When I fill the 'text' field 'Name' with 'External_Sites_2' under 'Identity'
    And I fill the 'text' field 'Site ID' with '2' under 'Identity'
    And I choose 'Wellington' option from the 'External Device' dropdown under 'Identity' section
    And I press the button with 'Save' label
    Then There is '2' rows in the table


  Scenario: Link to External Sites details page
    Given There is '2' rows in the table
    When I click on the text in row '1' and column 'Name'
    Then I am in the 'configure/external-sites-status/7' page


  Scenario: Creating a External Sites use Copy under detail page
    Given There is '2' rows in the table
    When I click on the text in row '1' and column 'Name'
    Then I am in the 'configure/external-sites-status/7' page
    When I press the button with 'Copy' label
    And I fill the 'text' field 'Name' with 'External_Sites_3' under 'Identity'
    And I fill the 'text' field 'Site ID' with '3' under 'Identity'
    And I choose 'Otago' option from the 'External Device' dropdown under 'Identity' section
    And I press the button with 'Save' label
    Then I am in the 'configure/external-sites-status/7' page
    When I press the button with 'Back' label
    Then I am in the 'configure/external-sites' page
    And There is '3' rows in the table


  Scenario: Edit a External Sites use button under the table
    Given There is '3' rows in the table
    When I select row '2' on the table
    Then There is 'Edit' button
    When I press the button with 'Edit' label
    Then I am in the 'configure/external-sites/8' page


  Scenario: Edit a External Sites use button under detail page with valid data
    Given There is '3' rows in the table
    When I click on the text in row '2' and column 'Name'
    Then I am in the 'configure/external-sites-status/8' page
    And There is 'Edit' button
    When I press the button with 'Edit' label
    Then I am in the 'configure/external-sites/8' page
    When I fill the 'text' field 'Name' with 'External_Sites_Edit' under 'Identity'
    And I fill the 'text' field 'Site ID' with 'f' under 'Identity'
    And I choose 'Wellington' option from the 'External Device' dropdown under 'Identity' section
    And I press the button with 'Save' label
    Then I am in the 'configure/external-sites-status/8' page
    And I can see the 'Name' is 'External_Sites_Edit' under 'Identity'
    And I can see the 'External RFSS' is 'Wellington' under 'Identity'


  Scenario: Add Adjacent Sites to A External Sites
    Given There is '3' rows in the table
    When I click on the text in row '1' and column 'Name'
    Then I am in the 'configure/external-sites-status/7' page
    And I can see the 'Sites' list box contain 'No available options' under 'Adjacent Sites' section
    When I press the button with 'Edit' label
    Then I am in the 'configure/external-sites/7' page
    When I choose 'SiteA' option from the 'Adjacent Sites' dropdown under 'Adjacent Sites' section
    And I press the button with 'Add' label
    And I choose 'SiteB' option from the 'Adjacent Sites' dropdown under 'Adjacent Sites' section
    And I press the button with 'Add' label
    And I press the button with 'Save' label
    Then I am in the 'configure/external-sites-status/7' page
    And I can see the 'Sites' list box contain 'SiteA' under 'Adjacent Sites' section
    And I can see the 'Sites' list box contain 'SiteB' under 'Adjacent Sites' section


  Scenario: Delete Adjacent Sites from A External Sites
    Given There is '3' rows in the table
    When I click on the text in row '1' and column 'Name'
    Then I am in the 'configure/external-sites-status/7' page
    And I can see the 'Sites' list box contain 'SiteA' under 'Adjacent Sites' section
    And I can see the 'Sites' list box contain 'SiteB' under 'Adjacent Sites' section
    When I press the button with 'Edit' label
    Then I am in the 'configure/external-sites/7' page
    When I select 'SiteA' from the 'Sites' list box under 'Adjacent Sites' section
    And I select 'SiteB' from the 'Sites' list box under 'Adjacent Sites' section
    And I press the button with 'Delete' label
    And I press the button with 'Save' label
    Then I am in the 'configure/external-sites-status/7' page
    And I can see the 'Sites' list box contain 'No available options' under 'Adjacent Sites' section


  Scenario Outline: Edit a External Sites form with invalid data
    Given There is '3' rows in the table
    When I select row '2' on the table
    And I press the button with 'Edit' label
    And I fill the 'text' field '<field_name>' with '<value>' under 'Identity'
    Then I see an error message '<error_msg>'
    And The button with 'Save' label is been disabled

    Examples:
      | field_name | value  | error_msg                         |
      | Name       |        | Empty value not allowed           |
      | Name       | spa ce | Illegal characters in input value |
      | Site ID    | 0      | Invalid Value (1 ~ FE)            |
      | Site ID    | ff     | Invalid Value (1 ~ FE)            |
      | Site ID    | string | Invalid Hex value                 |


  Scenario Outline: Filter RFSS Manager External Sites table
    Given There is at less '3' rows in the table
    When I input '<filter>' to the filter box
    Then There is '<left_user_count>' rows in the table

    Examples:
      | filter         | left_user_count |
      | External_Sites | 3               |
      | Wellington     | 2               |
      | f              | 1               |
      | random_test    | 0               |


  Scenario Outline: Sort RFSS Manager External Sites table with column <column>
    Given There is at less '3' rows in the table
    When I sort the table with '<column>' in ASC
    Then The '<column_type>' under the '<column>' is in 'ASC' order
    When I sort the table with '<column>' in DESC
    Then The '<column_type>' under the '<column>' is in 'DESC' order

    Examples:
      | column  | column_type |
      | Name    | string      |
      | Site ID | hex         |
      | RFSS ID | string      |


  Scenario: Delete a External Sites
    Given There is '3' rows in the table
    When I select row '2' on the table
    And I press the button with 'Delete' label
    And I press the button with 'OK' label
    Then There is '2' rows in the table


  Scenario: Delete more then one External Sites
    Given There is '2' rows in the table
    When I select row '0' on the table
    When I select row '1' on the table
    And I press the button with 'Delete Many' label
    And I press the button with 'OK' label
    Then There is '0' rows in the table
