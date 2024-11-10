@WebUI @Fleet-Manager
Feature: Fleet Manager - Supergroup
    WebUI Testing for Supergroup page

    Background: Logging into Fleet Manager
        Given I opened the 'Fleet Manager'
        When I logged in with the credential User: taitnet, Password: tait

    Scenario: Creating a Home RFSS Map for a Supergroup
        When I clicked on FM Groups RFSS Map menu
        And I press the Create button
        And I fill in the form with a Create Supergroup RFSS Map Scenario
        And I press the Save button
        Then the scenario Create Supergroup RFSS Map is successful

    Scenario: Creating Multiple Groups for Supergroup Scenario
        When I clicked on FM Groups menu
        And I press the Create Many button
        And I complete the Create Groups Import form
        And I press the Save button
        And I press the Import All button
        And I choose Yes on the dialog box
        And I press the Finish button
        Then the scenario Create Groups Import is successful
    
    Scenario: Creating a Intra-ISSI Home RFSS Map 
        When I clicked on FM Groups RFSS Map menu
        And I press the Create button
        And I fill in the form with a Create Intra-ISSI RFSS Map - Supergroup Scenario
        And I press the Save button
        Then the scenario Create Intra-ISSI RFSS Map - Supergroup is successful

    Scenario: Creating a Supergroup
        When I clicked on FM Supergroups menu
        And I press the Create button
        And I complete the form with a Create Supergroup scenario
        And I press the Save button
        Then the scenario Create Supergroup is successful
    
    Scenario: Editing a Supergroup
        When I clicked on FM Supergroups menu
        And I select row #1 from the Supergroups table
        And I press the View button
        And I press the Edit button
        And I complete the form with a Edit Supergroup scenario
        And I press the Save button
        Then the scenario Edit Supergroup is successful

    Scenario: Adding Homed Member to a Supergroup
        When I clicked on FM Supergroups menu
        And I select row #1 from the Supergroups table
        And I press the View button
        And I Add Homed Member to the Supergroup
        Then the scenario Adding Homed Member is successful
    
    Scenario: Adding Visiting Member to a Supergroup
        When I clicked on FM Supergroups menu
        And I select row #1 from the Supergroups table
        And I press the View button
        And I Add Visiting Member to the Supergroup
        Then the scenario Adding Visiting Member is successful

    Scenario: Deleting Members from a Supergroup
        When I clicked on FM Supergroups menu
        And I select row #1 from the Supergroups table
        And I press the View button
        And I select row #1 from the Supergroup Members table
        And I press the Delete button
        And I choose Yes on the dialog box
        Then deleting that Member is successful
        
    Scenario: Deleting a Supergroup
        When I clicked on FM Supergroups menu
        And I select row #1 from the Supergroups table
        And I press the Delete button
        And I choose Yes on the dialog box
        Then Deleting that Supergroup is successful
        
    Scenario: Deleting Multiple Groups
        When I clicked on FM Groups menu
        And I select the data from row #1 to #4 in the Groups table
        And I press the Delete Many button
        And I choose Yes on the dialog box
        Then deleting that Groups is successful

    Scenario Outline: Creating a Supergroup with invalid values
        When I clicked on FM Supergroups menu
        And I press the Create button
        And I complete the form with a <scenario> scenario
        And I press the Save button
        Then the error message should contain <error_msg>
    
        Examples:
           | scenario                                       | error_msg                         |
           | Supergroup - GroupID Not Defined in RFSS Map   | Unable to find Group Home Map     |
           | Supergroup - Missing Alias                     | Missing required field(s): alias  |
    
    Scenario: Deleting Multiple Groups Home RFSS Map
        When I clicked on FM Groups RFSS Map menu
        And I select the data from row #2 to #3 in the Groups RFSS Map table
        And I press the Delete Many button
        And I choose Yes on the dialog box
        Then deleting that Groups RFSS Maps is successful