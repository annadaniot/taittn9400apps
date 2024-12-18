@WebUI @RFSS-Manager
@configure @external-device
Feature: RFSS Manager - RFSS Mobile IP Home Agents
  Test the RFSS Manager Mobile IP Home Agents page

  Background: Opening the RFSS Manager Mobile IP Home Agents page
    Given I opened the 'RFSS Manager'
    And I logged in as User: 'taitnet', Password: 'tait'
    When I select 'Packet Data' from 'Configure' on navbar
    Then I am in the 'configure/mobile-ip-home-agent' page

  Scenario: Creating a Mobile IP Home Agent
    Given There is '0' rows in the table
    When I press the button with 'Create' label
    Then I am in the 'configure/mobile-ip-home-agent/create' page
    When I fill the 'text' field 'Name' with 'MIPHA_1' under 'Identity'
    And I choose 'Auckland' option from the 'External Device' dropdown under 'Identity' section
    And I press the button with 'Save' label
    Then There is '1' rows in the table


  Scenario: Creating a Mobile IP Home Agent use Copy under table
    Given There is '1' rows in the table
    When I select row '0' on the table
    And I press the button with 'Copy' label
    When I fill the 'text' field 'Name' with 'MIPHA_2' under 'Identity'
    And I choose 'Wellington' option from the 'External Device' dropdown under 'Identity' section
    And I fill the 'text' field 'Key' with '0123456789abcdef0123456789abcdef' under 'Identity'
    And I press the button with 'Save' label
    Then There is '2' rows in the table


  Scenario: Link to Mobile IP Home Agent details page
    Given There is '2' rows in the table
    When I click on the text in row '1' and column 'Name'
    Then I am in the 'configure/mobile-ip-home-agent/2' page


  Scenario: Creating a Mobile IP Home Agent use Copy under detail page
    Given There is '2' rows in the table
    When I click on the text in row '1' and column 'Name'
    Then I am in the 'configure/mobile-ip-home-agent/2' page
    When I press the button with 'Copy' label
    And I fill the 'text' field 'Name' with 'MIPHA_3' under 'Identity'
    And I choose 'Otago' option from the 'External Device' dropdown under 'Identity' section
    And I fill the 'text' field 'Key' with '0123456789abcdef0123456789abcdef' under 'Identity'
    And I press the button with 'Save' label
    Then I am in the 'configure/mobile-ip-home-agent/2' page
    When I press the button with 'Back' label
    Then I am in the 'configure/mobile-ip-home-agent' page
    And There is '3' rows in the table


  Scenario: Edit a Mobile IP Home Agent use button under the table
    Given There is '3' rows in the table
    When I select row '2' on the table
    Then There is 'Edit' button
    When I press the button with 'Edit' label
    Then I am in the 'configure/mobile-ip-home-agent/3/edit' page


  Scenario: Edit a Mobile IP Home Agent use button under detail page with valid data
    Given There is '3' rows in the table
    When I click on the text in row '2' and column 'Name'
    Then I am in the 'configure/mobile-ip-home-agent/3' page
    And There is 'Edit' button
    When I press the button with 'Edit' label
    Then I am in the 'configure/mobile-ip-home-agent/3/edit' page
    When I fill the 'text' field 'Name' with 'MIPHA_Edit' under 'Identity'
    And I choose 'Wellington' option from the 'External Device' dropdown under 'Identity' section
    And I fill the 'text' field 'Key' with 'fedcba9876543210fedcba9876543210' under 'Identity'
    And I press the button with 'Save' label
    Then I am in the 'configure/mobile-ip-home-agent/3' page
    And I can see the 'Name' is 'MIPHA_Edit' under 'Identity'
    And I can see the 'External Device' is 'Wellington' under 'Identity'
    And I can see the 'Key' is 'fedcba9876543210fedcba9876543210' under 'Identity'


  Scenario Outline: Edit a Mobile IP Home Agent form with invalid data
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


  Scenario Outline: Filter RFSS Manager Mobile IP Home Agent table
    Given There is at less '3' rows in the table
    When I input '<filter>' to the filter box
    Then There is '<left_user_count>' rows in the table

    Examples:
      | filter                           | left_user_count |
      | MIPHA_                           | 3               |
      | Wellington                       | 2               |
      | fedcba9876543210fedcba9876543210 | 1               |
      | random_test                      | 0               |


  Scenario Outline: Sort RFSS Manager Mobile IP Home Agent table with column <column>
    Given There is at less '3' rows in the table
    When I sort the table with '<column>' in ASC
    Then The '<column_type>' under the '<column>' is in 'ASC' order
    When I sort the table with '<column>' in DESC
    Then The '<column_type>' under the '<column>' is in 'DESC' order

    Examples:
      | column          | column_type |
      | Name            | string      |
      | External Device | string      |
      | Key             | option-hex  |


  Scenario: Delete a Mobile IP Home Agent
    Given There is '3' rows in the table
    When I select row '2' on the table
    And I press the button with 'Delete' label
    And I press the button with 'OK' label
    Then There is '2' rows in the table


  Scenario: Delete more then one Mobile IP Home Agent
    Given There is '2' rows in the table
    When I select row '0' on the table
    When I select row '1' on the table
    And I press the button with 'Delete Many' label
    And I press the button with 'OK' label
    Then There is '0' rows in the table
