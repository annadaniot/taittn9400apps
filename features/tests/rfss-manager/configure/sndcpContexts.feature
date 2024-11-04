@WebUI @RFSS-Manager
@configure @mobile-ip-home-agent
Feature: RFSS Manager - RFSS SNDCP Contexts
  Test the RFSS Manager SNDCP Contexts page

  Background: Opening the RFSS Manager SNDCP Contexts page
    Given I opened the 'RFSS Manager'
    And I logged in as User: 'taitnet', Password: 'tait'
    When I select 'Packet Data' from 'Configure' on navbar
    Then I am in the 'configure/mobile-ip-home-agent' page
    When I click 'SNDCP Contexts' from menu bar
    Then I am in the 'configure/sndcp-context' page


  Scenario: Creating a SNDCP Contexts
    Given There is '0' rows in the table
    When I press the button with 'Create' label
    Then I am in the 'configure/sndcp-context/create' page
    When I fill the 'text' field 'Name' with 'SNDCP_Context_1' under 'Identity'
    And I fill the 'number' field 'NSAPI' with '1' under 'Identity'
    And I fill the 'number' field 'Priority' with '1' under 'Identity'
    And I choose 'MIPHA_1' option from the 'Mobile Ip Home Agent' dropdown under 'Identity' section
    And I press the button with 'Save' label
    Then There is '1' rows in the table


  Scenario: Creating a SNDCP Contexts use Copy under table
    Given There is '1' rows in the table
    When I select row '0' on the table
    And I press the button with 'Copy' label
    When I fill the 'text' field 'Name' with 'SNDCP_Context_2' under 'Identity'
    And I fill the 'number' field 'NSAPI' with '2' under 'Identity'
    And I fill the 'number' field 'Priority' with '2' under 'Identity'
    And I choose 'MIPHA_2' option from the 'Mobile Ip Home Agent' dropdown under 'Identity' section
    And I press the button with 'Save' label
    Then There is '2' rows in the table


  Scenario: Link to SNDCP Contexts details page
    Given There is '2' rows in the table
    When I click on the text in row '1' and column 'Name'
    Then I am in the 'configure/sndcp-context/2' page


  Scenario: Creating a SNDCP Contexts use Copy under detail page
    Given There is '2' rows in the table
    When I click on the text in row '1' and column 'Name'
    Then I am in the 'configure/sndcp-context/2' page
    When I press the button with 'Copy' label
    And I fill the 'text' field 'Name' with 'SNDCP_Context_3' under 'Identity'
    And I fill the 'number' field 'NSAPI' with '3' under 'Identity'
    And I fill the 'number' field 'Priority' with '3' under 'Identity'
    And I choose 'MIPHA_3' option from the 'Mobile Ip Home Agent' dropdown under 'Identity' section
    And I press the button with 'Save' label
    Then I am in the 'configure/sndcp-context/2' page
    When I press the button with 'Back' label
    Then I am in the 'configure/sndcp-context' page
    And There is '3' rows in the table


  Scenario: Edit a SNDCP Contexts use button under the table
    Given There is '3' rows in the table
    When I select row '2' on the table
    Then There is 'Edit' button
    When I press the button with 'Edit' label
    Then I am in the 'configure/sndcp-context/3/edit' page


  Scenario: Edit a SNDCP Contexts use button under detail page with valid data
    Given There is '3' rows in the table
    When I click on the text in row '2' and column 'Name'
    Then I am in the 'configure/sndcp-context/3' page
    And There is 'Edit' button
    When I press the button with 'Edit' label
    Then I am in the 'configure/sndcp-context/3/edit' page
    When I fill the 'text' field 'Name' with 'SNDCP_Context_Edit' under 'Identity'
    And I fill the 'number' field 'NSAPI' with '4' under 'Identity'
    And I fill the 'number' field 'Priority' with '0' under 'Identity'
    And I choose 'MIPHA_1' option from the 'Mobile Ip Home Agent' dropdown under 'Identity' section
    And I press the button with 'Save' label
    Then I am in the 'configure/sndcp-context/3' page
    And I can see the 'Name' is 'SNDCP_Context_Edit' under 'Identity'
    And I can see the 'NSAPI' is '4' under 'Identity'
    And I can see the 'Priority' is '0' under 'Identity'
    And I can see the 'Mobile IP Home Agent' is 'MIPHA_1' under 'Identity'


  Scenario Outline: Edit a SNDCP Contexts form with invalid data
    Given There is '3' rows in the table
    When I select row '2' on the table
    And I press the button with 'Edit' label
    And I fill the '<type>' field '<field_name>' with '<value>' under 'Identity'
    Then I see an error message '<error_msg>'
    And The button with 'Save' label is been disabled

    Examples:
      | field_name | type   | value  | error_msg                         |
      | Name       | text   |        | Empty value not allowed           |
      | Name       | text   | spa ce | Illegal characters in input value |
      | Priority   | number | -1     | Invalid Value (0 ~ 15)            |
      | Priority   | number | 16     | Invalid Value (0 ~ 15)            |


  Scenario Outline: Filter RFSS Manager SNDCP Contexts table
    Given There is at less '3' rows in the table
    When I input '<filter>' to the filter box
    Then There is '<left_user_count>' rows in the table

    Examples:
      | filter         | left_user_count |
      | SNDCP_Context_ | 3               |
      | MIPHA_1        | 2               |
      | 4              | 1               |
      | random_test    | 0               |


  Scenario Outline: Sort RFSS Manager SNDCP Contexts table with column <column>
    Given There is at less '3' rows in the table
    When I sort the table with '<column>' in ASC
    Then The '<column_type>' under the '<column>' is in 'ASC' order
    When I sort the table with '<column>' in DESC
    Then The '<column_type>' under the '<column>' is in 'DESC' order

    Examples:
      | column               | column_type |
      | Name                 | string      |
      | NSAPI                | number      |
      | Priority             | number      |
      | Mobile IP Home Agent | string      |


  Scenario: Delete a SNDCP Contexts
    Given There is '3' rows in the table
    When I select row '2' on the table
    And I press the button with 'Delete' label
    And I press the button with 'OK' label
    Then There is '2' rows in the table


  Scenario: Delete more then one SNDCP Contexts
    Given There is '2' rows in the table
    When I select row '0' on the table
    And I select row '1' on the table
    And I press the button with 'Delete Many' label
    And I press the button with 'OK' label
    Then There is '0' rows in the table
