@WebUI @RFSS-Manager
@configure @external-site
Feature: RFSS Manager - RFSS Sites
  Test the RFSS Manager Sites page

  Background: Opening the RFSS Manager Sites page
    Given I opened the 'RFSS Manager'
    And I logged in as User: 'taitnet', Password: 'tait'
    When I select 'Sites' from 'Configure' on navbar
    Then I am in the 'configure/sites' page


  Scenario: Creating a Sites
    Given There is '0' rows in the table
    When I press the button with 'Create' label
    Then I am in the 'configure/sites/add' page
    When I fill the 'text' field 'Name' with 'Site_1' under 'Identity'
    And I fill the 'text' field 'IP Address' with '192.168.56.10' under 'Identity'
    And I fill the 'text' field 'SSH Port' with '2222' under 'Identity'
    And I fill the 'text' field 'Hostname' with 'Site1' under 'Identity'
    And I fill the 'text' field 'Site ID' with '1' under 'Identity'
    And I fill the 'text' field 'LRA' with '128' under 'Identity'
    And I fill the 'text' field 'NAC' with 'FF' under 'Identity'
    And I press the button with 'Save' label
    Then There is '1' rows in the table


  Scenario: Creating a Sites use Copy under table
    Given There is '1' rows in the table
    When I select row '0' on the table
    And I press the button with 'Copy' label
    When I fill the 'text' field 'Name' with 'Site_2' under 'Identity'
    And I fill the 'text' field 'IP Address' with '192.168.56.11' under 'Identity'
    And I fill the 'text' field 'Hostname' with 'Site2' under 'Identity'
    And I fill the 'text' field 'Site ID' with '2' under 'Identity'
    And I press the button with 'Save' label
    Then There is '2' rows in the table


  Scenario: Link to Sites details page
    Given There is '2' rows in the table
    When I click on the text in row '1' and column 'Name'
    Then I am in the 'configure/sites/3' page


  Scenario: Creating a Sites use Copy under detail page
    Given There is '2' rows in the table
    When I click on the text in row '1' and column 'Name'
    Then I am in the 'configure/sites/3' page
    When I press the button with 'Copy' label
    And I fill the 'text' field 'Name' with 'Site_3' under 'Identity'
    And I fill the 'text' field 'IP Address' with '192.168.56.12' under 'Identity'
    And I fill the 'text' field 'Hostname' with 'Site3' under 'Identity'
    And I fill the 'text' field 'Site ID' with '3' under 'Identity'
    And I press the button with 'Save' label
    Then I am in the 'configure/sites/3' page
    When I press the button with 'Back' label
    Then I am in the 'configure/sites' page
    And There is '3' rows in the table


  Scenario: Edit a Sites use button under the table
    Given There is '3' rows in the table
    When I select row '2' on the table
    Then There is 'Edit' button
    When I press the button with 'Edit' label
    Then I am in the 'configure/sites/4/edit' page


  Scenario: Edit a Sites use button under detail page with valid data
    Given There is '3' rows in the table
    When I click on the text in row '2' and column 'Name'
    Then I am in the 'configure/sites/4' page
    And There is 'Edit' button
    When I press the button with 'Edit' label
    Then I am in the 'configure/sites/4/edit' page
    When I fill the 'text' field 'Name' with 'Site_Edit' under 'Identity'
    And I fill the 'text' field 'SSH Port' with '22' under 'Identity'
    And I fill the 'text' field 'Hostname' with 'SitesEdit' under 'Identity'
    And I fill the 'text' field 'Site ID' with '5' under 'Identity'
    And I fill the 'text' field 'LRA' with '120' under 'Identity'
    And I press the button with 'Save' label
    Then I am in the 'configure/sites/4' page
    # TODO: enable after CNP25-4294 /*
    # And I can see the 'Name' is 'Site_Edit' under 'Identity'
    # And I can see the 'SSH Port' is '22' under 'Identity'
    # And I can see the 'Hostname' is 'SitesEdit' under 'Identity'
    # And I can see the 'Site ID' is '5' under 'Identity'
    # TODO: enable after CNP25-4294 */
    And I can see the 'Name' is 'Site_Edit'
    And I can see the 'SSH Port' is '22'
    And I can see the 'Hostname' is 'SitesEdit'
    And I can see the 'Site ID' is '5'


  Scenario: High Availability info only show up when Site is not colocated with RFSS
    Given There is '3' rows in the table
    When I select row '2' on the table
    Then There is 'Edit' button
    When I press the button with 'Edit' label
    Then I am in the 'configure/sites/4/edit' page
    When I 'check' on the check box 'Site is colocated with RFSS' under 'High Availability' section
    And There 'is no' 'checkbox' field 'High Availability enabled' under 'High Availability'
    When I 'uncheck' on the check box 'Site is colocated with RFSS' under 'High Availability' section
    And There 'is' 'checkbox' field 'High Availability enabled' under 'High Availability'


  Scenario: Pair info only show up when High Availability Enabled
    Given There is '3' rows in the table
    When I click on the text in row '2' and column 'Name'
    Then I am in the 'configure/sites/4' page
    And There is 'Edit' button
    When I press the button with 'Edit' label
    Then I am in the 'configure/sites/4/edit' page
    When I 'uncheck' on the check box 'Site is colocated with RFSS' under 'High Availability' section
    And I 'check' on the check box 'High Availability enabled' under 'High Availability' section
    Then There 'is' 'text' field 'Controller A host name' under 'High Availability'
    And There 'is' 'text' field 'Controller A IP address' under 'High Availability'
    And There 'is' 'text' field 'Controller B host name' under 'High Availability'
    And There 'is' 'text' field 'Controller B IP address' under 'High Availability'
    When I 'uncheck' on the check box 'High Availability enabled' under 'High Availability' section
    Then There 'is no' 'text' field 'Controller A host name' under 'High Availability'
    And There 'is no' 'text' field 'Controller A IP address' under 'High Availability'
    And There 'is no' 'text' field 'Controller B host name' under 'High Availability'
    And There 'is no' 'text' field 'Controller B IP address' under 'High Availability'


  Scenario: Filling out the High Availability section with valid HA data
    Given There is '3' rows in the table
    When I click on the text in row '2' and column 'Name'
    Then I am in the 'configure/sites/4' page
    And There is 'Edit' button
    When I press the button with 'Edit' label
    Then I am in the 'configure/sites/4/edit' page
    When I 'uncheck' on the check box 'Site is colocated with RFSS' under 'High Availability' section
    And I 'check' on the check box 'High Availability enabled' under 'High Availability' section
    And I fill the 'text' field 'Controller A host name' with 'Pair-A' under 'High Availability'
    And I fill the 'text' field 'Controller A IP address' with '127.0.2.1' under 'High Availability'
    And I fill the 'text' field 'Controller B host name' with 'Pair-B' under 'High Availability'
    And I fill the 'text' field 'Controller B IP address' with '127.0.2.2' under 'High Availability'
    And I press the button with 'Save' label
    # TODO: enable after CNP25-4294 /*
    # Then I can see the 'Status' is 'Enabled' under 'High Availability'
    # TODO: enable after CNP25-4294 */
    Then I can see the 'Status' is 'Enabled'


  Scenario: Filling out the High Availability section with valid stand alone data
    Given There is '3' rows in the table
    When I click on the text in row '2' and column 'Name'
    Then I am in the 'configure/sites/4' page
    And There is 'Edit' button
    When I press the button with 'Edit' label
    Then I am in the 'configure/sites/4/edit' page
    When I 'uncheck' on the check box 'Site is colocated with RFSS' under 'High Availability' section
    And I 'uncheck' on the check box 'High Availability enabled' under 'High Availability' section
    And I press the button with 'Save' label
    # TODO: enable after CNP25-4294 /*
    # Then I can see the 'Status' is 'Disabled' under 'High Availability'
    # TODO: enable after CNP25-4294 */
    Then I can see the 'Status' is 'Disabled'


  # TODO: Test colocated site option, when not using Full license


  Scenario: Filling out the pair info High Availability section with same ip
    Given There is '3' rows in the table
    When I select row '2' on the table
    Then There is 'Edit' button
    When I press the button with 'Edit' label
    Then I am in the 'configure/sites/4/edit' page
    When I 'check' on the check box 'High Availability enabled' under 'High Availability' section
    And I fill the 'text' field 'Controller A IP address' with '1.1.1.1' under 'High Availability'
    And I fill the 'text' field 'Controller B IP address' with '1.1.1.1' under 'High Availability'
    And I press the button with 'Save' label
    Then I see an error message 'IP duplicate with Controller B IP address.'
    And I see an error message 'IP duplicate with Controller A IP address.'


  Scenario Outline: Filling out the High Availability section with invalid data
    Given There is '3' rows in the table
    When I select row '2' on the table
    Then There is 'Edit' button
    When I press the button with 'Edit' label
    Then I am in the 'configure/sites/4/edit' page
    When I 'check' on the check box 'High Availability enabled' under 'High Availability' section
    And I fill the '<type>' field '<field_name>' with '<value>' under 'High Availability'
    And I press the button with 'Save' label if it's not disable
    Then I see an error message '<error_msg>'

    Examples:
      | field_name              | value  | type | error_msg      |
      | Controller A IP address |        | text | Invalid Format |
      | Controller A IP address | random | text | Invalid Format |
      | Controller B IP address |        | text | Invalid Format |
      | Controller B IP address | random | text | Invalid Format |


  Scenario: Filling out the TCCP parameters section with valid data
    Given There is '3' rows in the table
    When I click on the text in row '2' and column 'Name'
    Then I am in the 'configure/sites/4' page
    And There is 'Edit' button
    When I press the button with 'Edit' label
    Then I am in the 'configure/sites/4/edit' page
    When I fill the 'number' field 'Connection timeout (ms)' with '100500' under 'TCCP parameters'
    And I fill the 'number' field 'Heartbeat period (ms)' with '10500' under 'TCCP parameters'
    And I press the button with 'Save' label
    # TODO: enable after CNP25-4294 /*
    # Then I can see the 'Connection timeout (ms)' is '100,500' under 'TCCP parameters'
    # And I can see the 'Heartbeat period (ms)' is '10,500' under 'TCCP parameters'
    # TODO: enable after CNP25-4294 */
    Then I can see the 'Connection timeout (ms)' is '100,500'
    And I can see the 'Heartbeat period (ms)' is '10,500'


  Scenario Outline: Filling out the TCCP parameters section with invalid data
    Given There is '3' rows in the table
    When I click on the text in row '2' and column 'Name'
    Then I am in the 'configure/sites/4' page
    And There is 'Edit' button
    When I press the button with 'Edit' label
    Then I am in the 'configure/sites/4/edit' page
    When I fill the '<type>' field '<field_name>' with '<value>' under 'TCCP parameters'
    And I press the button with 'Save' label if it's not disable
    Then I see an error message '<error_msg>'

    Examples:
      | field_name              | value  | type   | error_msg                     |
      | Connection timeout (ms) |        | number | Invalid Value (1000 ~ 200000) |
      | Connection timeout (ms) | 999    | number | Invalid Value (1000 ~ 200000) |
      | Connection timeout (ms) | 200001 | number | Invalid Value (1000 ~ 200000) |
      | Heartbeat period (ms)   |        | number | Invalid Value (1000 ~ 30000)  |
      | Heartbeat period (ms)   | 999    | number | Invalid Value (1000 ~ 30000)  |
      | Heartbeat period (ms)   | 30001  | number | Invalid Value (1000 ~ 30000)  |


  Scenario: Filling out the QOS section with valid data
    Given There is '3' rows in the table
    When I click on the text in row '2' and column 'Name'
    Then I am in the 'configure/sites/4' page
    And There is 'Edit' button
    When I press the button with 'Edit' label
    Then I am in the 'configure/sites/4/edit' page
    When I fill the 'number' field 'DSCP control' with '31' under 'QOS'
    And I fill the 'number' field 'DSCP voice' with '31' under 'QOS'
    And I fill the 'number' field 'Max reserved channels when partitioning active' with '12' under 'QOS'
    And I press the button with 'Save' label
    # TODO: enable after CNP25-4294 /*
    # Then I can see the 'DSCP control' is '31' under 'QOS'
    # And I can see the 'DSCP voice' is '31' under 'QOS'
    # And I can see the 'Max reserved channels when partitioning active' is '12' under 'QOS'
    # TODO: enable after CNP25-4294 */
    Then I can see the 'DSCP control' is '31'
    And I can see the 'DSCP voice' is '31'
    And I can see the 'Max reserved channels when partitioning active' is '12'


  Scenario Outline: Filling out the QOS section with invalid data
    Given There is '3' rows in the table
    When I click on the text in row '2' and column 'Name'
    Then I am in the 'configure/sites/4' page
    And There is 'Edit' button
    When I press the button with 'Edit' label
    Then I am in the 'configure/sites/4/edit' page
    When I fill the '<type>' field '<field_name>' with '<value>' under 'QOS'
    And I press the button with 'Save' label if it's not disable
    Then I see an error message '<error_msg>'

    Examples:
      | field_name                                     | value | type   | error_msg              |
      | DSCP control                                   |       | number | Invalid Value (0 ~ 63) |
      | DSCP control                                   | -1    | number | Invalid Value (0 ~ 63) |
      | DSCP control                                   | 64    | number | Invalid Value (0 ~ 63) |
      | DSCP voice                                     |       | number | Invalid Value (0 ~ 63) |
      | DSCP voice                                     | -1    | number | Invalid Value (0 ~ 63) |
      | DSCP voice                                     | 64    | number | Invalid Value (0 ~ 63) |
      | Max reserved channels when partitioning active |       | number | Valid range (0 - 24)   |
      | Max reserved channels when partitioning active | -1    | number | Valid range (0 - 24)   |
      | Max reserved channels when partitioning active | 25    | number | Valid range (0 - 24)   |


  Scenario: Add Adjacent Sites to A Sites
    Given There is '3' rows in the table
    When I click on the text in row '2' and column 'Name'
    Then I am in the 'configure/sites/4' page
    # TODO: change after CNP25-4294
    And I can see the 'Sites' list box have '0' rows
    When I press the button with 'Edit' label
    Then I am in the 'configure/sites/4/edit' page
    When I choose 'Site_1' option from the 'AdjacentSites' dropdown under 'Adjacent sites' section
    And I press the button with 'Add' label for 'Sites' under 'Adjacent sites' section
    And I choose 'Site_2' option from the 'AdjacentSites' dropdown under 'Adjacent sites' section
    And I press the button with 'Add' label for 'Sites' under 'Adjacent sites' section
    And I press the button with 'Save' label
    Then I am in the 'configure/sites/4' page
    # TODO: enable after CNP25-4294 /*
    # And I can see the 'Sites' list box contain 'Site1' under 'Adjacent Sites' section
    # And I can see the 'Sites' list box contain 'Site2' under 'Adjacent Sites' section
    # TODO: enable after CNP25-4294 */
    And I can see the 'Sites' list box have '2' rows


  Scenario: Delete Adjacent Sites from A Sites
    Given There is '3' rows in the table
    When I click on the text in row '2' and column 'Name'
    Then I am in the 'configure/sites/4' page
    # TODO: change after CNP25-4294
    And I can see the 'Sites' list box have '2' rows
    When I press the button with 'Edit' label
    Then I am in the 'configure/sites/4/edit' page
    When I select 'Site_1' from the 'Sites' list box under 'Adjacent sites' section
    And I select 'Site_2' from the 'Sites' list box under 'Adjacent sites' section
    And I press the button with 'Delete' label for 'Sites' under 'Adjacent sites' section
    And I press the button with 'Save' label
    Then I am in the 'configure/sites/4' page
    # TODO: change after CNP25-4294
    And I can see the 'Sites' list box have '0' rows


  Scenario: Add Adjacent External Sites to A Sites
    Given There is '3' rows in the table
    When I click on the text in row '2' and column 'Name'
    Then I am in the 'configure/sites/4' page
    # TODO: change after CNP25-4294
    And I can see the 'External Sites' list box have '0' rows
    When I press the button with 'Edit' label
    Then I am in the 'configure/sites/4/edit' page
    When I choose 'External_Sites_1' option from the 'ExternalAdjacentSites' dropdown under 'Adjacent sites' section
    And I press the button with 'Add' label for 'External Sites' under 'Adjacent sites' section
    And I choose 'External_Sites_3' option from the 'ExternalAdjacentSites' dropdown under 'Adjacent sites' section
    And I press the button with 'Add' label for 'External Sites' under 'Adjacent sites' section
    And I press the button with 'Save' label
    Then I am in the 'configure/sites/4' page
    # TODO: enable after CNP25-4294 /*
    # And I can see the 'External Sites' list box contain 'External_Sites_1' under 'Adjacent Sites' section
    # And I can see the 'External Sites' list box contain 'External_Sites_3' under 'Adjacent Sites' section
    # TODO: enable after CNP25-4294 */
    And I can see the 'External Sites' list box have '2' rows


  Scenario: Delete Adjacent External Sites from A Sites
    Given There is '3' rows in the table
    When I click on the text in row '2' and column 'Name'
    Then I am in the 'configure/sites/4' page
    # TODO: change after CNP25-4294
    And I can see the 'External Sites' list box have '2' rows
    When I press the button with 'Edit' label
    Then I am in the 'configure/sites/4/edit' page
    When I select 'External_Sites_1' from the 'External Sites' list box under 'Adjacent sites' section
    And I select 'External_Sites_3' from the 'External Sites' list box under 'Adjacent sites' section
    And I press the button with 'Delete' label for 'External Sites' under 'Adjacent sites' section
    And I press the button with 'Save' label
    Then I am in the 'configure/sites/4' page
    # TODO: change after CNP25-4294
    And I can see the 'External Sites' list box have '0' rows


  Scenario: Filling out the Packet data section with valid data
    Given There is '3' rows in the table
    When I click on the text in row '2' and column 'Name'
    Then I am in the 'configure/sites/4' page
    And There is 'Edit' button
    When I press the button with 'Edit' label
    Then I am in the 'configure/sites/4/edit' page
    When I choose '3 minutes' option from the 'Sndcp Ready Time' dropdown under 'Packet data' section
    And I fill the 'number' field 'Outbound message timeout (sec)' with '28' under 'Packet data'
    And I fill the 'number' field 'Maximum SUs per data channel' with '127' under 'Packet data'
    And I press the button with 'Save' label
    # TODO: enable after CNP25-4294 /*
    # Then I can see the 'SNDCP ready time' is '3 minutes' under 'Packet data'
    # And I can see the 'Outbound message timeout (sec)' is '31' under 'Packet data'
    # And I can see the 'Maximum SUs per data channel' is '127' under 'Packet data'
    # TODO: enable after CNP25-4294 */
    Then I can see the 'SNDCP ready time' is '3 minutes'
    And I can see the 'Outbound message timeout (sec)' is '28'
    And I can see the 'Maximum SUs per data channel' is '127'


  Scenario Outline: Filling out the Packet data section with invalid data
    Given There is '3' rows in the table
    When I click on the text in row '2' and column 'Name'
    Then I am in the 'configure/sites/4' page
    And There is 'Edit' button
    When I press the button with 'Edit' label
    Then I am in the 'configure/sites/4/edit' page
    When I fill the '<type>' field '<field_name>' with '<value>' under 'Packet data'
    And I press the button with 'Save' label if it's not disable
    Then I see an error message '<error_msg>'

    Examples:
      | field_name                     | value | type   | error_msg               |
      | Outbound message timeout (sec) |       | number | Invalid Value (4 ~ 60)  |
      | Outbound message timeout (sec) | 3     | number | Invalid Value (4 ~ 60)  |
      | Outbound message timeout (sec) | 61    | number | Invalid Value (4 ~ 60)  |
      | Maximum SUs per data channel   |       | number | Invalid Value (1 ~ 255) |
      | Maximum SUs per data channel   | 0     | number | Invalid Value (1 ~ 255) |
      | Maximum SUs per data channel   | 256   | number | Invalid Value (1 ~ 255) |


  Scenario: Filling out the Data API connector section with valid data
    Given There is '3' rows in the table
    When I click on the text in row '2' and column 'Name'
    Then I am in the 'configure/sites/4' page
    And There is 'Edit' button
    When I press the button with 'Edit' label
    Then I am in the 'configure/sites/4/edit' page
    When I 'check' on the check box 'Enable Data API' under 'Data API connector' section
    And I fill the 'text' field 'IP Address' with '127.0.0.50' under 'Data API connector'
    And I fill the 'number' field 'Port' with '4000' under 'Data API connector'
    And I press the button with 'Save' label
    # TODO: enable after CNP25-4294 /*
    # Then I can see the 'Enable Data API' is 'Yes' under 'Data API connector'
    # And I can see the 'IP Address' is '127.0.0.50' under 'Data API connector'
    # And I can see the 'Port' is '4,000' under 'Data API connector'
    # TODO: enable after CNP25-4294 */
    Then I can see the 'Enable Data API' is 'Yes'
    And I can see the 'IP Address' is '127.0.0.50'
    And I can see the 'Port' is '4,000'


  Scenario Outline: Filling out the Data API connector section with invalid data
    Given There is '3' rows in the table
    When I click on the text in row '2' and column 'Name'
    Then I am in the 'configure/sites/4' page
    And There is 'Edit' button
    When I press the button with 'Edit' label
    Then I am in the 'configure/sites/4/edit' page
    When I fill the '<type>' field '<field_name>' with '<value>' under 'Data API connector'
    And I press the button with 'Save' label if it's not disable
    Then I see an error message '<error_msg>'

    Examples:
      | field_name | value  | type   | error_msg                    |
      | IP Address |        | text   | Invalid IP format            |
      | IP Address | random | text   | Invalid IP format            |
      | Port       |        | number | Invalid Value (1023 ~ 65535) |
      | Port       | 1022   | number | Invalid Value (1023 ~ 65535) |
      | Port       | 65536  | number | Invalid Value (1023 ~ 65535) |


  Scenario Outline: Filter RFSS Manager Sites table
    Given There is at less '3' rows in the table
    When I input '<filter>' to the filter box
    Then There is '<left_user_count>' rows in the table

    Examples:
      | filter        | left_user_count |
      | Site          | 3               |
      | 128           | 2               |
      | 192.168.56.11 | 1               |
      | random_test   | 0               |


  Scenario Outline: Sort RFSS Manager Sites table with column <column>
    Given There is at less '3' rows in the table
    When I sort the table with '<column>' in ASC
    Then The '<column_type>' under the '<column>' is in 'ASC' order
    When I sort the table with '<column>' in DESC
    Then The '<column_type>' under the '<column>' is in 'DESC' order

    Examples:
      | column     | column_type |
      | Name       | string      |
      | IP Address | string      |
      | Site ID    | hex         |
      | LRA        | number      |
      | NAC        | hex         |


  Scenario: Delete a Sites
    Given There is '3' rows in the table
    When I select row '2' on the table
    And I press the button with 'Delete' label
    And I press the button with 'OK' label
    Then There is '2' rows in the table


  Scenario: Delete more then one Sites
    Given There is '2' rows in the table
    When I select row '0' on the table
    When I select row '1' on the table
    And I press the button with 'Delete Many' label
    And I press the button with 'OK' label
    Then There is '0' rows in the table
