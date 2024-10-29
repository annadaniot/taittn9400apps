@WebUI @Fleet-Manager
Feature: Fleet Manager - Groups 
    WebUI Testing for Groups page

    Background: Logging into Fleet Manager
        Given I opened the 'Fleet Manager'
        When I logged in with the credential User: taitnet, Password: tait
        And I clicked on FM Groups menu

    Scenario: Creating Group
        When I press the Create button
        And I complete the Create Group form
        And I press the Save button
        Then the scenario Create Group is successful

    Scenario: Editing Group
        When I select row #1 from the Groups table
        And I press the View button
        And I press the Edit button
        And I will do Edit Group
        And I press the Save button
        Then the scenario Edit Group is successful

    Scenario: Adding Location Restriction to a Group
        When I select row #1 from the Groups table
        And I press the View button
        And I clicked on Group Location Permissions section
        And I select row #2 from the Group Location Permissions table
        Then the Group is restricted to that location

    Scenario: Deleting Group
        When I select row #1 from the Groups table
        And I press the Delete button
        And I choose Yes on the dialog box
        Then deleting that Group is successful

    Scenario: Creating Multiple Groups
        When I press the Create Many button
        And I complete the Create Groups Import form
        And I press the Save button
        And I press the Import All button
        And I choose Yes on the dialog box
        And I press the Finish button
        Then the scenario Create Groups Import is successful

    Scenario: Deleting Multiple Groups
        When I select the data from row #1 to #4 in the Groups table
        And I press the Delete Many button
        And I choose Yes on the dialog box
        Then deleting that Groups is successful


