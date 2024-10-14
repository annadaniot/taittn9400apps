@WebUI @Fleet-Manager
Feature: Fleet Manager - Backups
    WebUI Testing for Fleet Backups page

    Background: Logging into Fleet Manager
        Given I opened the 'Fleet Manager'
        When I logged in with the credential User: taitnet, Password: tait
        And I clicked on FM Fleet Backups menu
    
    Scenario: Creating a Fleet Backups
        When I Create a Fleet Backup
        Then the table contains the newest Fleet Backup
    
    Scenario: Deleting a Fleet Backup file
        When I select row #1 from the Fleet Backup table
        And I press the Delete button
        And I choose Yes on the dialog box
        Then deleting that Fleet Backup file is successful

    Scenario: Restoring a Fleet Backup
	    When I created Groups and added other changes to it by mistake
        And I restore the latest Fleet Backup file
        Then the previously correct data is now restored

    Scenario: Downloading a Fleet Backup file
        When I select row #1 from the Fleet Backup table
        And download that latest backup file
        Then the file is in the downloads folder
       
