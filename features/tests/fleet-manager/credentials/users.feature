@WebUI @Fleet-Manager
Feature: Fleet Manager - Users
    WebUI Testing for Users page

    Background: Logging into Fleet Manager
        Given I opened the 'Fleet Manager'
        When I logged in with the credential User: taitnet, Password: tait
        And I clicked on FM Users menu

    Scenario: Creating a FM user
        When I press the Create button
        And I fill out the Create User form
        And I press the Save button
        Then the scenario Create User is successful
    
    Scenario: Logging in using new credential
        Given I clicked the logout button
        When I login using the new credential
        Then I am able to see the Fleet Manager home page
       
    Scenario: Editing an FM user details
        When I select row #4 from the Users table
        And I press the View button
        And I press the Edit button
        And I fill out the Edit User form
        And I press the Save button
        Then the scenario Edit User is successful
        
    Scenario: Deleting an FM user
        When I select row #4 from the Users table
        And I press the Delete button
        And I choose Yes on the dialog box
        Then the scenario User Delete is successful



  
       