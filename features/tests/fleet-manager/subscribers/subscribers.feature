@WebUI @Fleet-Manager
Feature: Fleet Manager - Subscriber
    WebUI Testing for Subscriber page

    Background: Logging into Fleet Manager
        Given I opened the 'Fleet Manager'
        When I logged in with the credential User: taitnet, Password: tait
        And I clicked on FM Subscribers menu

    Scenario: Creating Subscriber
        When I press the Create button
        And I fill in the Create Subscriber form
        And I press the Save button
        Then the scenario Create Subscriber is successful

    Scenario: Editing Subscriber
        When I select row #1 from the Subscribers table
        And I press the View button
        And I press the Edit button
        And I'll do the scenario Edit Subscriber
        And I press the Save button
        Then the scenario Edit Subscriber is successful

    Scenario: Adding Location Restriction to a Subscriber Unit
        When I select row #1 from the Subscribers table
        And I press the View button
        And I clicked on Subscriber Location Permissions section
        And I select row #1 from the Subscriber Location Permissions table
        And I press the Save button
        Then the Subscriber is restricted to that location

    Scenario: Deleting Subscriber
        When I select row #1 from the Subscribers table
        And I press the Delete button
        And I choose Yes on the dialog box
        Then deleting that Subscriber is successful

    Scenario: Creating Multiple Subscribers
        When I press the Create Many button
        And I fill in the Create Subscribers Import form
        And I press the Save button
        And I press the Import All button
        And I choose Yes on the dialog box
        And I press the Finish button
        Then the scenario Create Subscribers Import is successful

    Scenario: Deleting Multiple Subscribers
        When I select the data from row #1 to #4 in the Subscriber table
        And I press the Delete Many button
        And I choose Yes on the dialog box
        Then deleting that Subscribers is successful

