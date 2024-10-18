@WebUI @RFSS-Manager
Feature: RFSS Manager Login
  Logging in Scenarios for the RFSS Manager

  Background: Opening the RFSS Manager
    Given I opened the 'RFSS Manager'
    Then I am in the 'login' page


  Scenario: Login and Logout from RFSS Manager with a correct user
    Given I logged in as User: 'taitnet', Password: 'tait'
    Then Login is successful
    And I am in the 'configure/rfss' page
    When I press the 'Logout' text
    Then I confirm Logout on the dialog box
    Then I am in the 'login' page


  Scenario: Login on the RFSS Manager with an incorrect user
    Given I logged in as User: 'random_user', Password: 'random_psw'
    Then Error dialog box is show on the page
    And I am in the 'login' page


  Scenario: Login on the RFSS Manager is password case sensitive
    Given I logged in as User: 'taitnet', Password: 'Tait'
    Then Error dialog box is show on the page
    And I am in the 'login' page
