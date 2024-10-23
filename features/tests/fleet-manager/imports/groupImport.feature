@WebUI @Fleet-Manager
Feature: Fleet Manager - Imports
    WebUI Testing for Groups Import page

    Background: Logging into Fleet Manager
        Given I opened the 'Fleet Manager'
        When I logged in with the credential User: taitnet, Password: tait
        And I clicked on FM Groups Import menu
    
    Scenario: Creating Announcement Group
        When I clicked on FM Groups menu
        And I press the Create button
        And I complete the Create Announcement Group form
        And I press the Save button
        Then the scenario Create Announcement Group is successful
            
    Scenario: Creating Groups Import
        When I press the Create button
        And I complete the Create Groups Import form
        And I press the Save button
        And I press the Import All button
        And I choose Yes on the dialog box
        And I press the Finish button
        Then the scenario Create Groups Import is successful

    Scenario: Uploading CSV file for Group Import
        When I press the Upload button
        And I upload the Groups Import CSV file
        And I press the Import All button
        And I choose Yes on the dialog box
        And I press the Finish button
        Then the scenario Groups Import - Upload is successful

    Scenario: Deleting all Groups
        When I clicked on FM Groups menu
        And I click on the all checkbox
        And I press the Delete Many button
        And I choose Yes on the dialog box


