@WebUI @RFSS-Manager
@configure @empty
Feature: RFSS Manager - Logging Profiles
  Test the RFSS Manager Logging Profiles page

  Background: Opening the RFSS Manager Logging Profiles page
    Given I opened the 'RFSS Manager'
    And I logged in as User: 'taitnet', Password: 'tait'
    When I select 'Logging profile' from 'Profiles' on navbar
    Then I am in the 'configure/profiles/log' page


  Scenario: There is no edit button for the Default profile on table
    Given There is '1' rows in the table
    When I select row '0' on the table
    Then There is no 'Edit' button


  Scenario: Link to Logging Profile View page
    Given There is '1' rows in the table
    When I click on the text in row '0' and column 'Name'
    Then I am in the 'configure/profiles/log/1' page


  Scenario: There is no edit button for the Default profile on detail page
    Given There is '1' rows in the table
    When I select row '0' on the table
    Then There is no 'Edit' button


  Scenario: There is undeleteable profile call Default
    Given There is '1' rows in the table
    When I select row '0' on the table
    And I press the button with 'Delete' label
    Then A dialog shown 'You cannot delete the default profile.' on the page


  Scenario: Creating a Logging Profiles use button under table
    Given There is '1' rows in the table
    When I press the button with 'Create' label
    Then I am in the 'configure/profiles/log/create' page
    When I fill the 'text' field 'Profile name' with 'New_Logging_Profile_1' under 'Identity'
    And I 'check' on the check box 'Enable SIP stack logging' under 'Identity' section
    And I 'check' on the check box 'Enable Fleet Manager Debug Log' under 'Identity' section
    And I fill the 'text' field 'Syslog Server IP Address' with '127.0.0.1' under 'Identity'
    And I fill the 'number' field 'Syslog Server Port number' with '1514' under 'Identity'
    And I press the button with 'Save' label
    Then There is '2' rows in the table


  Scenario: Copy a Logging Profiles use button under table
    Given There is '2' rows in the table
    When I select row '0' on the table
    And I press the button with 'Copy' label
    Then I am in the 'configure/profiles/log/1/copy' page


  Scenario: Copy a Logging Profiles use button under detail page
    Given There is '2' rows in the table
    When I click on the text in row '1' and column 'Name'
    Then I am in the 'configure/profiles/log/2' page
    When I press the button with 'Copy' label
    Then I am in the 'configure/profiles/log/2/copy' page
    When I fill the 'text' field 'Profile name' with 'New_Logging_Profile_2' under 'Identity'
    And I 'uncheck' on the check box 'Enable SIP stack logging' under 'Identity' section
    And I 'uncheck' on the check box 'Enable Fleet Manager Debug Log' under 'Identity' section
    And I fill the 'text' field 'Syslog Server IP Address' with '127.0.0.2' under 'Identity'
    And I fill the 'number' field 'Syslog Server Port number' with '2514' under 'Identity'
    And I press the button with 'Save' label
    Then I am in the 'configure/profiles/log/2' page
    When I press the button with 'Back' label
    Then I am in the 'configure/profiles/log' page
    And There is '3' rows in the table


  Scenario: Edit a Logging Profiles use button under table
    Given There is '3' rows in the table
    When I select row '1' on the table
    And I press the button with 'Edit' label
    Then I am in the 'configure/profiles/log/2/edit' page


  Scenario: Edit a Logging Profiles use button under detail page
    Given There is '3' rows in the table
    When I click on the text in row '2' and column 'Name'
    Then I am in the 'configure/profiles/log/3' page
    # Update after CNP25-4268
    And I can see the 'Enable SIP stack logging' is 'No'
    When I press the button with 'Edit' label
    Then I am in the 'configure/profiles/log/3/edit' page
    When I fill the 'text' field 'Profile name' with 'New_Logging_Profile_Edit' under 'Identity'
    And I 'check' on the check box 'Enable SIP stack logging' under 'Identity' section
    And I 'check' on the check box 'Enable Fleet Manager Debug Log' under 'Identity' section
    And I fill the 'text' field 'Syslog Server IP Address' with '127.0.0.3' under 'Identity'
    And I fill the 'number' field 'Syslog Server Port number' with '3514' under 'Identity'
    And I press the button with 'Save' label
    Then I am in the 'configure/profiles/log/3' page
    # Update after CNP25-4268 /*
    And I can see the 'Profile name' is 'New_Logging_Profile_Edit'
    And I can see the 'Enable SIP stack logging' is 'Yes'
    And I can see the 'Enable Fleet Manager Debug Log' is 'Yes'
    And I can see the 'Syslog Server IP Address' is '127.0.0.3'
    And I can see the 'Syslog Server Port number' is '3514'
  # Update after CNP25-4268 */


  Scenario Outline: Edit all log level to <log_level> in a Logging Profiles
    Given There is '3' rows in the table
    When I click on the text in row '2' and column 'Name'
    Then I am in the 'configure/profiles/log/3' page
    When I press the button with 'Edit' label
    And I choose '<log_level>' option from the 'ScLoggingLevel' dropdown under 'Identity' section
    And I choose '<log_level>' option from the 'LoggingSipStackLevel' dropdown under 'Identity' section
    And I choose '<log_level>' option from the 'RtpLoggingLevel' dropdown under 'Identity' section
    And I choose '<log_level>' option from the 'NifLoggingLevel' dropdown under 'Identity' section
    And I choose '<log_level>' option from the 'McLoggingLevel' dropdown under 'Identity' section
    And I choose '<log_level>' option from the 'GeneralLoggingLevel' dropdown under 'Identity' section
    And I choose '<log_level>' option from the 'RegistryLoggingLevel' dropdown under 'Identity' section
    And I choose '<log_level>' option from the 'ThreadLoggingLevel' dropdown under 'Identity' section
    And I choose '<log_level>' option from the 'SocketLoggingLevel' dropdown under 'Identity' section
    And I choose '<log_level>' option from the 'RtiLoggingLevel' dropdown under 'Identity' section
    And I choose '<log_level>' option from the 'ControllerLoggingLevel' dropdown under 'Identity' section
    And I choose '<log_level>' option from the 'LinkLoggingLevel' dropdown under 'Identity' section
    And I choose '<log_level>' option from the 'FaultMgrLoggingLevel' dropdown under 'Identity' section
    And I choose '<log_level>' option from the 'TransceiverLoggingLevel' dropdown under 'Identity' section
    And I choose '<log_level>' option from the 'ConfiguratorLoggingLevel' dropdown under 'Identity' section
    And I choose '<log_level>' option from the 'InformationLoggingLevel' dropdown under 'Identity' section
    And I choose '<log_level>' option from the 'SipaLoggingLevel' dropdown under 'Identity' section
    And I choose '<log_level>' option from the 'TrxaLoggingLevel' dropdown under 'Identity' section
    And I choose '<log_level>' option from the 'DataLoggingLevel' dropdown under 'Identity' section
    And I choose '<log_level>' option from the 'AcctLoggingLevel' dropdown under 'Identity' section
    And I choose '<log_level>' option from the 'SnmpLoggingLevel' dropdown under 'Identity' section
    And I choose '<log_level>' option from the 'VlrLoggingLevel' dropdown under 'Identity' section
    And I choose '<log_level>' option from the 'DfsiVoiceLoggingLevel' dropdown under 'Identity' section
    And I choose '<log_level>' option from the 'LrIfLoggingLevel' dropdown under 'Identity' section
    And I choose '<log_level>' option from the 'RgLoggingLevel' dropdown under 'Identity' section
    And I choose '<log_level>' option from the 'PstngLoggingLevel' dropdown under 'Identity' section
    And I choose '<log_level>' option from the 'MobileIpLoggingLevel' dropdown under 'Identity' section
    And I choose '<log_level>' option from the 'PdSnContextLoggingLevel' dropdown under 'Identity' section
    And I choose '<log_level>' option from the 'PacketDataLoggingLevel' dropdown under 'Identity' section
    And I choose '<log_level>' option from the 'PdMonLoggingLevel' dropdown under 'Identity' section
    And I choose '<log_level>' option from the 'DapiLoggingLevel' dropdown under 'Identity' section
    And I press the button with 'Save' label
    Then I am in the 'configure/profiles/log/3' page
    And I can see the 'Site controller log level' is '<log_level>'
    And I can see the 'SIP stack log level' is '<log_level>'
    And I can see the 'RTP log level' is '<log_level>'
    And I can see the 'NIF log level' is '<log_level>'
    And I can see the 'Media controller log level' is '<log_level>'
    And I can see the 'General log level' is '<log_level>'
    And I can see the 'Registry log level' is '<log_level>'
    And I can see the 'Thread log level' is '<log_level>'
    And I can see the 'Socket log level' is '<log_level>'
    And I can see the 'RTI log level' is '<log_level>'
    And I can see the 'Controller log level' is '<log_level>'
    And I can see the 'Link log level' is '<log_level>'
    And I can see the 'Fault manager log level' is '<log_level>'
    And I can see the 'Transceiver log level' is '<log_level>'
    And I can see the 'Configurator log level' is '<log_level>'
    And I can see the 'Information log level' is '<log_level>'
    And I can see the 'SIP adapter log level' is '<log_level>'
    And I can see the 'TRX adapter log level' is '<log_level>'
    And I can see the 'Data log level' is '<log_level>'
    And I can see the 'Accounting log level' is '<log_level>'
    And I can see the 'SNMP log level' is '<log_level>'
    And I can see the 'VLR log level' is '<log_level>'
    And I can see the 'DFSI voice log level' is '<log_level>'
    And I can see the 'Location register interface log level' is '<log_level>'
    And I can see the 'RNC log level' is '<log_level>'
    And I can see the 'PSTNG log level' is '<log_level>'
    And I can see the 'Mobile IP log level' is '<log_level>'
    And I can see the 'Packet data subnet context log level' is '<log_level>'
    And I can see the 'Packet data log level' is '<log_level>'
    And I can see the 'Packet data monitoring log level' is '<log_level>'
    And I can see the 'Data API log level' is '<log_level>'

    Examples:
      | log_level |
      | DEBUG     |
      | DETAILED  |
      | NORMAL    |
      | EXCEPTION |
      | CRITICAL  |


  Scenario Outline: Edit a Logging Profiles with invalid data
    Given There is '3' rows in the table
    When I click on the text in row '2' and column 'Name'
    Then I am in the 'configure/profiles/log/3' page
    When I press the button with 'Edit' label
    And I fill the '<type>' field '<field_name>' with '<value>' under '<section>'
    Then I see an error message '<error_msg>'
    And The button with 'Save' label is been disabled

    Examples:
      | field_name                | type   | section  | value  | error_msg                         |
      | Profile name              | text   | Identity |        | Empty value not allowed           |
      | Profile name              | text   | Identity | spa ce | Illegal characters in input value |
      | Syslog Server Port number | number | Identity | 0      | Invalid Value (1 ~ 65535)         |
      | Syslog Server Port number | number | Identity | 65536  | Invalid Value (1 ~ 65535)         |


  Scenario Outline: Filter RFSS Manager Logging Profiles table
    Given There is at less '3' rows in the table
    When I input '<filter>' to the filter box
    Then There is '<left_user_count>' rows in the table

    Examples:
      | filter      | left_user_count |
      | f           | 3               |
      | Logging     | 2               |
      | Default     | 1               |
      | random_test | 0               |


  Scenario: Sort RFSS Manager Logging Profiles table with column Name
    Given There is at less '3' rows in the table
    When I sort the table with 'Name' in ASC
    Then The 'string' under the 'Name' is in 'ASC' order
    When I sort the table with 'Name' in DESC
    Then The 'string' under the 'Name' is in 'DESC' order


  Scenario Outline: Choose all Logging Profiles from <page_name> Page
    Given There is at less '3' rows in the table
    When I select '<page_name>' from 'Configure' on navbar
    And I press the button with 'Edit' label
    Then I am in the '<url>' page
    And There 'is' dropdown 'Log Profile' under 'Profiles'
    And There is '3' options in the dropdown 'Log Profile' under 'Profiles'

    Examples:
      | page_name     | url                          |
      | RFSS          | configure/rfss/edit          |
      | Fleet Manager | configure/fleet-manager/edit |
      | PSTN Gateway  | configure/pstn-gateway/edit  |


  Scenario: Choose all Logging Profiles from Site Page
    Given There is at less '3' rows in the table
    When I select section 'Sites' on navbar
    Then I am in the 'configure/sites' page
    When I press the button with 'Create' label
    Then I am in the 'configure/sites/add' page
    And There 'is' dropdown 'Log Profile' under 'Profiles'
    And There is '3' options in the dropdown 'Log Profile' under 'Profiles'


  Scenario: Delete more then one Logging Profiles
    Given There is '3' rows in the table
    When I select row '1' on the table
    And I select row '2' on the table
    Then There is 'Delete Many' button


  Scenario: Delete a Logging Profiles
    Given There is '3' rows in the table
    When I select row '2' on the table
    And I press the button with 'Delete' label
    And I press the button with 'OK' label
    Then There is '2' rows in the table
