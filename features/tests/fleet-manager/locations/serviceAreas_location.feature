@WebUI @Fleet-Manager
Feature: Fleet Manager - Locations 
    WebUI Testing for Service Areas page

    Background: Logging into Fleet Manager
        Given I opened the 'Fleet Manager'
        When I logged in with the credential User: taitnet, Password: tait
 
    Scenario: Creating Service Area
        When I clicked on FM Service Areas menu
        And I press the Create button
        And I fill-out the Create Service Area form
        And I press the Save button
        Then the scenario Create Service Area is successful

    Scenario: Editing Service Area
        When I clicked on FM Service Areas menu
        And I select row #1 from the Service Areas table
        And I press the View button
        And I press the Edit button
        And I fill-out the Edit Service Area form
        And I press the Save button
        Then the scenario Edit Service Area is successful
    
    Scenario: Adding Location to a Service Area
        When I clicked on FM Service Areas menu
        And I select row #1 from the Service Areas table
        And I press the View button
        And I clicked on Location section
        And I select row #1 from the Service Areas-Location table
        Then the scenario Adding Location to a Service Area is successful
        
    Scenario: Adding Subscriber Home RFSS to a Service Area
        When I clicked on FM Service Areas menu
        And I select row #1 from the Service Areas table
        And I press the View button
        And I clicked on Subscriber Home RFSS section
        And I select row #1 from the Service Areas-Subscriber Home RFSS table
        Then the scenario Adding Subscriber Home RFSS to a Service Area is successful
        
    Scenario: Adding Group Home RFSS to a Service Area
        When I clicked on FM Service Areas menu
        And I select row #1 from the Service Areas table
        And I press the View button
        And I clicked on Group Home RFSS section
        And I select row #1 from the Service Areas-Group Home RFSS table
        Then the scenario Adding Group Home RFSS to a Service Area is successful           
    
    Scenario: Deleting Restrictions to a Location in Service Area
        When I clicked on FM Service Areas menu
        And I select row #1 from the Service Areas table
        And I press the View button
        And I clicked on Location section
        And I select row #1 from the Service Areas-Location table
        Then the scenario Deleting Restriction to a Location in Service Area is successful
        
    Scenario: Deleting Restrictions to a Subscriber Home RFSS in Service Area
        When I clicked on FM Service Areas menu
        And I select row #1 from the Service Areas table
        And I press the View button  
        And I clicked on Subscriber Home RFSS section
        And I select row #1 from the Service Areas-Subscriber Home RFSS table
        Then the scenario Deleting Restriction to a Subscriber Home RFSS in Service Area is successful
            
    Scenario: Deleting Restrictions to a Group Home RFSS in Service Area
        When I clicked on FM Service Areas menu
        And I select row #1 from the Service Areas table
        And I press the View button
        And I clicked on Group Home RFSS section
        And I select row #1 from the Service Areas-Group Home RFSS table
        Then the scenario Deleting Restriction to a Group Home RFSS in Service Area is successful
    
    Scenario: Adding Service Area to a Location
        When I clicked on FM Locations menu
        And I select row #1 from the Locations table
        And I press the View button
        And I clicked on Service Area section
        And I select row #1 from the Service Areas table
        And I press the Save button
        Then the scenario Adding Service Area to a Location is successful 
    
    Scenario: Removing Service Area to a Location
        When I clicked on FM Locations menu
        And I select row #1 from the Locations table
        And I press the View button
        And I clicked on Service Area section
        And I select row #1 from the Service Areas table
        And I press the Save button
        Then the scenario Removing Service Area to a Location is successful 

    Scenario: Deleting Service Area
        When I clicked on FM Service Areas menu
        And I select row #1 from the Service Areas table
        And I press the Delete button
        And I choose Yes on the dialog box
        Then deleting that Service Area is successful

    Scenario Outline: Creating Service Area with Missing Name
        When I clicked on FM Service Areas menu
        And I press the Create button
        And I fill-out the <scenario> form
        And I press the Save button
        Then the error message should contain <error_msg>

        Examples:
           | scenario                          |error_msg                                 |
           | Service Area - Missing Area Name  | Missing required field(s): serviceArea   |
           