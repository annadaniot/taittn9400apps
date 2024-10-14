@WebUI @UFleet-Manager
Feature: Fleet Manager - Backups
    WebUI Testing for Users Backups page

    Background: Logging into Fleet Manager
       Given I opened the 'Fleet Manager'
        When I logged in with the credential User: taitnet, Password: tait
        And I clicked on FM Users Backups menu
    
    Scenario: Generate a Users Backup
        When I Create a Users Backup
        Then the table contains the newest Users Backup
    
    Scenario: Deleting a Users Backup file
        When I select row #1 from the Users Backup table
        And I press the Delete button
        And I choose Yes on the dialog box
        Then deleting that Users Backup file is successful

    Scenario: Restoring a Users Backup
	    When I created user and added other changes to it by mistake
        And I restore the latest Users Backup file
        Then the previously correct data is now restored

    Scenario: Downloading a Users Backup file
        When I select row #1 from the Users Backup table
        And download that latest backup file
        Then the file is in the downloads folder
       
