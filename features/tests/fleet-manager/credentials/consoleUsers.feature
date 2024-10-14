@WebUI @Fleet-Manager
Feature: Fleet Manager - Console Users
    WebUI Testing for Console Users page

    Background: Logging into Fleet Manager
        Given I opened the 'Fleet Manager'
        When I logged in with the credential User: taitnet, Password: tait
        And I clicked on FM Console Users menu

    Scenario: Creating a console user
        When I press the Create button
        And I fill out the Create Console User form
        And I press the Save button
        Then the scenario Create User is successful
     
    Scenario: Editing a console user details
        When I select row #1 from the Users table
        And I press the View button
        And I press the Edit button
        And I fill out the Edit Console User form
        And I press the Save button
        Then the scenario Edit Console User is successful
        
    Scenario: Deleting a console user
        When I select row #1 from the Console Users table
        And I press the Delete button
        And I choose Yes on the dialog box
        Then the scenario Console User Delete is successful



  
       