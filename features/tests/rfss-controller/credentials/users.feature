@WebUI @RFSS-Controller
@authentication.db @tait_p25rc.db
Feature: RFSS Controller - Users
	WebUI Testing for Users page

	Background: Logging and go to users page on RFSS Controller
		Given I opened the 'RFSS Controller'
		And I logged in as User: 'taitnet', Password: 'tait'
		When I select 'Users' from 'Credentials' on navbar


	Scenario Outline: Editing User's Access Level to <access_level>
		Given Row '0' is has 'test_user_1' in column 'Username'
		When I select row '0' on the table
		And I press the button with 'Edit' label
		When I change the Access level into Access-Level: '<access_level>'
		And I press the button with 'Save' label
		Then Row '0' is has '<access_level>' in column 'Access Level'
		And Row '0' is has 'test_user_1' in column 'Username'

		Examples:
			| access_level |
			| Disabled     |
			| Read only    |
			| Read/Write   |


	Scenario: RFSS Controller Users table sort Username in ASC as default
		Given There is at less '2' rows in the table
		And The tables is not sort on table as default
		Then Row '0' is has 'test_user_1' in column 'Username'
		And Row '1' is has 'test_user_2' in column 'Username'


	Scenario Outline: Sort RFSS Controller Users table with column <column>
		Given There is at less '2' rows in the table
		When I sort the table with '<column>' in ASC
		Then Row '0' is has '<user_one>' in column '<column>'
		And Row '1' is has '<user_two>' in column '<column>'
		When I sort the table with '<column>' in DESC
		Then Row '0' is has '<user_two>' in column '<column>'
		And Row '1' is has '<user_one>' in column '<column>'

		Examples:
			| column       | user_one    | user_two    |
			| Username     | test_user_1 | test_user_2 |
			| Name         | Test 1      | Test 2      |
			| Access Level | Disabled    | Read/Write  |


	Scenario Outline: Filter RFSS Controller Users table
		Given Row '0' is has 'test_user_1' in column 'Username'
		And Row '1' is has 'test_user_2' in column 'Username'
		When I input '<filter>' to the filter box
		Then There is '<left_user_count>' rows in the table

		Examples:
			| filter      | left_user_count |
			| random_test | 0               |
			| test_user_1 | 1               |
			| Test 1      | 1               |
			| test_user   | 2               |
			| Test        | 2               |
