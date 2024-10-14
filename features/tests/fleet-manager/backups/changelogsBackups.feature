@WebUI @Fleet-Manager
Feature: Fleet Manager - Backups
    WebUI Testing for Users Backups page

    Background: Logging into Fleet Manager
       Given I opened the 'Fleet Manager'
        When I logged in with the credential User: taitnet, Password: tait
        And I clicked on FM Change Logs Backups menu
    
    Scenario: Creating a Change Logs Backup
        When I Create a Change Logs Backup
        Then the table contains the newest Change Logs Backup

    Scenario: Downloading a Change Logs Backup file
        When I select row #1 from the Change Logs Backup table
        And download that latest backup file
        Then the file is in the downloads folder 
    
    Scenario: Deleting a Change Logs Backup file
        When I select row #1 from the Change Logs Backup table
        And I press the Delete button
        And I choose Yes on the dialog box
        Then deleting that Change Logs Backup file is successful

