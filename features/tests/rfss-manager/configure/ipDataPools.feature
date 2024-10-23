@WebUI @RFSS-Manager
@configure @empty
Feature: RFSS Manager - RFSS IP Data Pools
  Fills out the RFSS Manager IP Data Pools page

  Background: Opening the RFSS Manager
    Given I opened the 'RFSS Manager'
    And I logged in as User: 'taitnet', Password: 'tait'
    When I select 'Packet Data' from 'Configure' on navbar
    Then I am in the 'configure/mobile-ip-home-agent' page
    When I click 'IP Data Pools' from menu bar
    Then I am in the 'configure/ip-data-pools' page


  Scenario: Creating a IP Data Pools
    Given There is '0' rows in the table
    When I press the button with 'Create' label
    Then I am in the 'configure/ip-data-pools/create' page
    When I fill the 'text' field 'Name' with 'Pool_1' under 'Identity'
    And I fill the 'text' field 'IP address range (CIDR)' with '10.214.191.224/27' under 'Identity'
    And I choose 'IPv4 Dynamic' option from the 'pool_type' dropdown under 'Identity' section
    And I press the button with 'Save' label
    Then There is '1' rows in the table


  Scenario: Creating a IP Data Pools use Copy under table
    Given There is '1' rows in the table
    When I select row '0' on the table
    And I press the button with 'Copy' label
    And I fill the 'text' field 'Name' with 'Pool_2' under 'Identity'
    And I fill the 'text' field 'IP address range (CIDR)' with '10.214.192.224/27' under 'Identity'
    And I choose 'IPv4 Static' option from the 'pool_type' dropdown under 'Identity' section
    And I press the button with 'Save' label
    Then There is '2' rows in the table


  Scenario: Link to IP Data Pools details page
    Given There is '2' rows in the table
    When I click on the text in row '1' and column 'Name'
    Then I am in the 'configure/ip-data-pools/2' page


  Scenario: Creating a IP Data Pools use Copy under detail page
    Given There is '2' rows in the table
    When I click on the text in row '1' and column 'Name'
    Then I am in the 'configure/ip-data-pools/2' page
    When I press the button with 'Copy' label
    And I fill the 'text' field 'Name' with 'Pool_3' under 'Identity'
    And I fill the 'text' field 'IP address range (CIDR)' with '10.214.193.224/27' under 'Identity'
    And I choose 'IPv4 Static' option from the 'pool_type' dropdown under 'Identity' section
    And I press the button with 'Save' label
    Then I am in the 'configure/ip-data-pools/2' page
    When I press the button with 'Back' label
    Then I am in the 'configure/ip-data-pools' page
    And There is '3' rows in the table


  Scenario: Edit a IP Data Pools use button under the table
    Given There is '3' rows in the table
    When I select row '2' on the table
    Then There is 'Edit' button
    When I press the button with 'Edit' label
    Then I am in the 'configure/ip-data-pools/3/edit' page


  Scenario: Edit a IP Data Pools use button under detail page with valid data
    Given There is '3' rows in the table
    When I click on the text in row '2' and column 'Name'
    Then I am in the 'configure/ip-data-pools/3' page
    And There is 'Edit' button
    When I press the button with 'Edit' label
    Then I am in the 'configure/ip-data-pools/3/edit' page
    When I fill the 'text' field 'Name' with 'Pool_Edit' under 'Identity'
    And I fill the 'text' field 'IP address range (CIDR)' with '10.214.195.224/27' under 'Identity'
    And I choose 'IPv4 Dynamic' option from the 'pool_type' dropdown under 'Identity' section
    And I press the button with 'Save' label
    Then I am in the 'configure/ip-data-pools/3' page
    And I can see the 'Name' is 'Pool_Edit' under 'Identity'
    And I can see the 'IP address range (CIDR)' is '10.214.195.224/27' under 'Identity'
    And I can see the 'Pool type' is 'IPv4 Dynamic' under 'Identity'


  Scenario Outline: Edit a IP Data Pools form with invalid data
    Given There is '3' rows in the table
    When I select row '2' on the table
    And I press the button with 'Edit' label
    And I fill the '<type>' field '<field_name>' with '<value>' under 'Identity'
    Then I see an error message '<error_msg>'
    And The button with 'Save' label is been disabled

    Examples:
      | field_name              | type | value   | error_msg                            |
      | Name                    | text |         | Empty value not allowed              |
      | Name                    | text | spa ce  | Illegal characters in input value    |
      | IP address range (CIDR) | text |         | Empty value not allowed              |
      | IP address range (CIDR) | text | ramdom  | The IP format should be: IPv4/Prefix |
      | IP address range (CIDR) | text | 1.1.1.1 | The IP format should be: IPv4/Prefix |


  Scenario Outline: Filter RFSS Manager IP Data Pools table
    Given There is at less '3' rows in the table
    When I input '<filter>' to the filter box
    Then There is '<left_user_count>' rows in the table

    Examples:
      | filter            | left_user_count |
      | Pool_             | 3               |
      | IPv4 Dynamic      | 2               |
      | 10.214.191.224/27 | 1               |
      | random_test       | 0               |


  Scenario Outline: Sort RFSS Manager IP Data Pools table with column <column>
    Given There is at less '3' rows in the table
    When I sort the table with '<column>' in ASC
    Then The '<column_type>' under the '<column>' is in 'ASC' order
    When I sort the table with '<column>' in DESC
    Then The '<column_type>' under the '<column>' is in 'DESC' order

    Examples:
      | column                  | column_type |
      | Name                    | string      |
      | IP address range (CIDR) | string      |
      | Pool type               | string      |


  Scenario: Delete a IP Data Pools
    Given There is '3' rows in the table
    When I select row '2' on the table
    And I press the button with 'Delete' label
    And I press the button with 'OK' label
    Then There is '2' rows in the table


  Scenario: Delete more then one IP Data Pools
    Given There is '2' rows in the table
    When I select row '0' on the table
    And I select row '1' on the table
    And I press the button with 'Delete Many' label
    And I press the button with 'OK' label
    Then There is '0' rows in the table
