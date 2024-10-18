@WebUI @Site-Controller
Feature: Site Controller - Login
  Logging in Scenarios for the Site Controller

  Background: Opening the Site Controller
    Given I opened the 'Site Controller'
    Then I am in the 'login' page


  Scenario: Login and Logout from Site Controller with a correct user
    Given I logged in as User: 'taitnet', Password: 'tait'
    Then Login is successful
    And I am in the 'settings' page
    When I press the 'Logout' text
    Then I confirm Logout on the dialog box
    Then I am in the 'login' page


  Scenario: Login on the Site Controller with an incorrect user
    Given I logged in as User: 'random_user', Password: 'random_psw'
    Then Error dialog box is show on the page
    And I am in the 'login' page
