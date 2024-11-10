@WebUI @Fleet-Manager
Feature: Fleet Manager - Subscribers Home RFSS Map
    WebUI Testing for Subscribers Home RFSS Map page

    Background: Logging into Fleet Manager
        Given I opened the 'Fleet Manager'
        When I logged in with the credential User: taitnet, Password: tait
        And I clicked on FM Subscriber RFSS Map menu

    Scenario: Creating Subscriber Home RFSS Map
        When I press the Create button
        And I fill in the form with a Create Subscriber RFSS Map Scenario
        And I press the Save button
        Then the scenario Create Subscriber RFSS Map is successful

    Scenario: Editing Subscriber Home RFSS Map
        When I select row #2 from the Groups Home RFSS Map table
        And I press the View button
        And I press the Edit button
        And I do Edit Subscribers RFSS Map
        And I press the Save button
        Then the scenario Edit Subscribers RFSS Map is successful

    Scenario: Splitting Subscriber Home RFSS Map
        When I select row #2 from the SU Home RFSS Map table
        And I press the Split button
        And I split the SU RFSS Map into 2 maps with the first one having max Unit ID of 71300
        Then splitting into 2 maps is successful

    Scenario: Deleting Multiple Subscribers Home RFSS Maps
        When I select the data from row #2 to #3 in the Subscribers RFSS Map table
        And I press the Delete Many button
        And I choose Yes on the dialog box
        Then deleting that Subscribers RFSS Maps is successful
    
    Scenario Outline: Creating a Subscriber Home RFSS Map with invalid values
        When I press the Create button
        And I fill in the form with a <scenario> Scenario
        And I press the Save button
        Then the error message should contain <error_msg>

        Examples:
           | scenario                                    | error_msg                      |    
           | Subscriber Home RFSS Map - Missing WACN     | Invalid WACN ID                |
           | Subscriber Home RFSS Map - Missing System ID| Invalid System ID              |
           | Subscriber Home RFSS Map - Missing RFSS ID  | Invalid RFSS ID                |
           | Subscriber Home RFSS Map - Missing Minimum  | No minimum Unit ID provided   |
           | Subscriber Home RFSS Map - Missing Maximum  | No maximum Unit ID provided   |
           | Subscriber Home RFSS Map - Missing Alias    | No alias provided              |
