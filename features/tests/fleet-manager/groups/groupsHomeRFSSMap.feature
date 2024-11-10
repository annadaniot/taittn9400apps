@WebUI @Fleet-Manager
Feature: Fleet Manager - Groups Home RFSS Map
    WebUI Testing for Groups Home RFSS Map page

    Background: Logging into Fleet Manager
        Given I opened the 'Fleet Manager'
        When I logged in with the credential User: taitnet, Password: tait
        And I clicked on FM Groups RFSS Map menu

    Scenario: Creating Groups Home RFSS Map
        When I press the Create button
        And I fill in the form with a Create Groups RFSS Map Scenario
        And I press the Save button
        Then the scenario Create Groups RFSS Map is successful

    Scenario: Editing Groups Home RFSS Map
        When I select row #2 from the Groups Home RFSS Map table
        And I press the View button
        And I press the Edit button
        And I do Edit Groups RFSS Map
        And I press the Save button
        Then the scenario Edit Groups RFSS Map is successful

    Scenario: Splitting Groups Home RFSS Map
        When I select row #2 from the Groups Home RFSS Map table
        And I press the Split button
        And I split the Group Home RFSS Map into 2 maps with the first one having max Unit ID of 7230
        Then splitting into 2 maps is successful

    Scenario: Deleting Multiple Groups Home RFSS Map
        When I select the data from row #2 to #3 in the Groups RFSS Map table
        And I press the Delete Many button
        And I choose Yes on the dialog box
        Then deleting that Groups RFSS Maps is successful
    
    Scenario Outline: Creating a Group Home RFSS Map with invalid values
        When I press the Create button
        And I fill in the form with a <scenario> Scenario
        And I press the Save button
        Then the error message should contain <error_msg>

        Examples:
           | scenario                               | error_msg                      |    
           | Group Home RFSS Map - Missing WACN     | Invalid WACN ID                |
           | Group Home RFSS Map - Missing System ID| Invalid System ID              |
           | Group Home RFSS Map - Missing RFSS ID  | Invalid RFSS ID                |
           | Group Home RFSS Map - Missing Minimum  | No minimum Group ID provided   |
           | Group Home RFSS Map - Missing Maximum  | No maximum Group ID provided   |
           | Group Home RFSS Map - Missing Alias    | No alias provided              |
           
           