@WebUI @RFSS-Controller
Feature: RFSS Controller - Password
  WebUI Testing for Change Password page

  Background: Logging and go to change password page on RFSS Controller
    Given I opened the 'RFSS Controller'
    And I logged in as User: 'taitnet', Password: 'tait'
    When I select 'Password' from 'Credentials' on navbar
    Then I am in the 'change-password' page


  Scenario: Changing password - Happy case
    When I fill the Passwords page with 'tait', 'tait' and 'tait'
    And I press the button with 'Save' label
    Then I am in the 'users' page


  Scenario: Changing password - Password does not match Scenario
    When I fill the Passwords page with 'wrong_psw', 'tait' and 'tait'
    And I press the button with 'Save' label
    Then I see a error message 'You entered an incorrect current password.'
    And I press the button with 'OK' label


  Scenario: Changing password - Incorrect Password Scenario
    When I fill the Passwords page with 'tait', 'tait' and 'random'
    Then I see a error message 'The confirm password do not match'
    And button with 'Save' label is been disabled
