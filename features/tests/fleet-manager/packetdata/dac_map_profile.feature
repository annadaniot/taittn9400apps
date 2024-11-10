@WebUI @Fleet-Manager
Feature: Fleet Manager - Packet Data
    WebUI Testing for DAC Group Profiles page

    Background: Logging into Fleet Manager
        Given I opened the 'Fleet Manager'
        When I logged in with the credential User: taitnet, Password: tait

    Scenario: Creating DAC Group Profile
        When I clicked on FM DAC Group Profiles menu
        And I press the Create button
        And I submit the Create DAC Group Profile form with the required details
        And I press the Save button
        Then the scenario Create DAC Group Profile is successful

    Scenario Outline: Creating DAC Group Profile with invalid data
        When I clicked on FM DAC Group Profiles menu
        And I press the Create button
        And I submit the <scenario> form with the required details
        And I press the Save button
        Then the error message should contain <error_msg>

      Examples:
           | scenario                                              | error_msg                              |    
           | DAC Group Profile - Missing Name                      | Missing required field(s): dacgrpName  |
           | DAC Group Profile - Missing DAC Group ID              | int_type: dacId                        |
           | DAC Group Profile - Missing OTAR Port Number          | int_type: otarPortNumber               |
           | DAC Group Profile - Missing Location Data Port Number | int_type: locationDataPortNumber       |
           | DAC Group Profile - Missing OTAP Port Number          | int_type: otapPortNumber               |
           | DAC Group Profile - Duplicate DAC Group Profile Name  | DAC Group Profile Name already exists  |

    Scenario: Editing DAC Group Profile
        When I clicked on FM DAC Group Profiles menu
        And I select row #2 from the DAC Group Profiles table
        And I press the View button
        And I press the Edit button
        And I submit the Edit DAC Group Profile form with the required details
        And I press the Save button
        Then the scenario Edit DAC Group Profile is successful
    
    Scenario: Creating DAC Group Map
        When I clicked on FM DAC Group Map menu
        And I press the Create button
        And I input data into the Create DAC Group Map form
        And I press the Save button
        Then the scenario Create DAC Group Map is successful
    
    Scenario: Editing DAC Group Map
        When I clicked on FM DAC Group Map menu
        And I select row #1 from the DAC Group Map table
        And I press the View button
        And I press the Edit button
        And I input data into the Edit DAC Group Map form
        And I press the Save button
        Then the scenario Edit DAC Group Map is successful

    Scenario: Deleting DAC Group Map
        When I clicked on FM DAC Group Map menu
        And I select row #1 from the DAC Group Map table
        And I press the Delete button
        And I choose Yes on the dialog box
        Then deleting that DAC Group Map is successful
    
    Scenario: Deleting DAC Group Profile
        When I clicked on FM DAC Group Profiles menu
        And I select row #2 from the DAC Group Profile table
        And I press the Delete button
        And I choose Yes on the dialog box
        Then deleting that DAC Group Profile is successful