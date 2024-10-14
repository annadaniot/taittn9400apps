@WebUI @Fleet-Manager
Feature: Fleet Manager - Imports
    WebUI Testing for Subscribers Import page

    Background: Logging into Fleet Manager
        Given I opened the 'Fleet Manager'
        When I logged in with the credential User: taitnet, Password: tait
        And I clicked on FM Subscribers Import menu

    Scenario: Creating Subscribers Import
        When I press the Create button
        And I fill in the Create Subscribers Import form
        And I press the Save button
        And I press the Import All button
        And I choose Yes on the dialog box
        And I press the Finish button
        Then the scenario Create Subscribers Import is successful

    Scenario: Uploading CSV file for Subscriber Import
        When I press the Upload button
        And I upload the Subscribers Import CSV file
        And I press the Import All button
        And I choose Yes on the dialog box
        And I press the Finish button
        Then the scenario Subscribers Import - Upload is successful

    Scenario: Deleting all Subscribers
        When I clicked on FM Subscribers menu
        And I click on the all checkbox
        And I press the Delete Many button
        And I choose Yes on the dialog box


