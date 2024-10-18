import re
from behave import given, when, then, register_type
from playwright._impl import _errors as playwright_errors
from playwright.sync_api import Page, expect
from features.logger import logger
from datetime import datetime
import parse


# ***********************************************************
# *                        Constants                        *
# ***********************************************************
class LOCATOR:
    TABLE_ROWS = "table.p-datatable-table tbody tr"
    TABLE_HEADER = "tr[role='row'][data-pc-section='root']"


class CONSTANTS:
    NO_ROWS_TO_DISPLAY = "No rows to display."
    DOWNLOAD_BACKUP_NAME = "ui-test-backup-file.tar.gz"


# ***********************************************************
# *                        CONVERTERs                       *
# ***********************************************************
@parse.with_pattern(r".*")
def parse_string(text):
    return text


# -- REGISTER TYPE-CONVERTER: With behave
register_type(String=parse_string)


# ***********************************************************
# *                     Util Functions                      *
# ***********************************************************
def logout(context):
    logger.info("Controller, logout...")
    press_a_text(context, "Logout")
    confirm_logout_from_dialog(context)


def select_row_from_table(context, row_num, column_name):
    page: Page = context.page
    page.wait_for_selector(LOCATOR.TABLE_HEADER, timeout=5000)
    page.get_by_text("Loading...").wait_for(timeout=1000, state="hidden")
    headers = page.locator("tr[role='row'][data-pc-section='root'] th")

    column_index = -1
    for i in range(headers.count()):
        if headers.nth(i).inner_text() == column_name:
            column_index = i
            logger.debug(f"Index of {column_name} column is {i}")
            break
    assert column_index >= 0

    columns = page.locator(f"tr[data-p-index='{row_num}'] td")
    data = columns.nth(column_index).inner_text()
    logger.debug(f"Data of {column_name} column is row {i} is {data}")
    return data


def wait_for_rows_to_loaded(page: Page):
    rows = page.locator(LOCATOR.TABLE_ROWS)
    try:
        rows.nth(10).wait_for(state="visible", timeout=1000)
    except playwright_errors.TimeoutError:
        logger.debug("There is no row in this table")
    return rows


def get_form_section_by_name(page: Page, name: str):
    forms = page.locator("div.tait-full-form table")
    for i in range(forms.count()):
        section = forms.nth(i).locator("label").nth(0)
        if section.inner_text() == name:
            return forms.nth(i)


def wait_until_page_loaded(page: Page):
    page.wait_for_timeout(50)
    page.get_by_role("progressbar").wait_for(timeout=5000, state="hidden")


# ***********************************************************
# *                          Steps                          *
# ***********************************************************
@then("I am in the '{page_name}' page")
def open_login_page(context, page_name):
    page: Page = context.page
    wait_until_page_loaded(page)
    expect(page).to_have_url(re.compile(fr".*\/#\/{page_name}$"))


@given("I logged in as User: '{username}', Password: '{password}'")
def input_login_with_credentials(context, username, password):
    page: Page = context.page

    username_input = page.locator("#username_txt")
    username_input.clear()
    username_input.fill(username)
    password_input = page.locator("input[type=\"password\"]")
    password_input.clear()
    password_input.fill(password)
    login_btn = page.get_by_role("button", name="Login")
    for _ in range(5):
        login_btn.click()
        login_btn.locator('svg[data-pc-section="loadingicon"]').wait_for(timeout=10000, state="hidden")
        if page.get_by_text("ErrorYou must wait a while").is_visible():
            press_a_button_with_label(context, "OK")
            logger.info("stop, waiting")
            page.wait_for_timeout(1000)
        else:
            break


@when("I press the '{text}' text")
def press_a_text(context, text):
    page: Page = context.page
    page.get_by_text(text).click()


@then("I confirm Logout on the dialog box")
def confirm_logout_from_dialog(context):
    page: Page = context.page
    expect(page.locator("div").filter(has_text=re.compile(r"^Confirm$"))).to_be_visible()
    page.get_by_role("button", name="Logout").click()


@then("Error dialog box is show on the page")
def shown_error_dialog(context):
    page: Page = context.page
    expect(page.get_by_text("Error")).to_be_visible()


@when("I select '{page_name}' from '{section_name}' on navbar")
def go_to_password_page(context, page_name, section_name):
    page: Page = context.page
    page.locator("div").filter(has_text=re.compile(fr"^{section_name}$")).first.click()
    page.get_by_role("link", name=page_name).click()


@when("I fill the Passwords page with '{old_password}', '{new_password}' and '{confirm_new_password}'")
def filling_password_page(context, old_password, new_password, confirm_new_password):
    page: Page = context.page
    page.get_by_role("textbox").first.fill(old_password)
    page.get_by_role("textbox").nth(1).fill(new_password)
    page.get_by_role("textbox").nth(2).fill(confirm_new_password)


@given("I press the button with '{button_name}' label")
@when("I press the button with '{button_name}' label")
@then("I press the button with '{button_name}' label")
def press_a_button_with_label(context, button_name):
    page: Page = context.page
    page.get_by_label(button_name, exact=True).click()


@then("I see an error message '{error_message}'")
def see_error_message(context, error_message):
    page: Page = context.page
    expect(page.get_by_text(error_message, )).to_be_visible()


@then("The button with '{button_name}' label is been disabled")
def button_is_disabled(context, button_name):
    page: Page = context.page
    expect(page.get_by_label(button_name)).to_be_disabled()


@given("Row '{row_num}' has '{expect_data}' in column '{column_name}'")
@then("Row '{row_num}' has '{expect_data}' in column '{column_name}'")
def check_data_from_table(context, row_num, expect_data, column_name):
    data = select_row_from_table(context, row_num, column_name)
    assert data == expect_data, f"{data=} {expect_data=}"


@when("I select row '{row_num}' on the table")
def select_row_from_user_table_by_username(context, row_num):
    page: Page = context.page
    row = page.locator(f"tr[data-p-index='{row_num}']")
    row.locator("input[type='checkbox']").click()


@when("I change the Access level into Access-Level: '{access_level}'")
def change_the_access_level(context, access_level):
    page: Page = context.page
    page.click("#access-level")
    page.get_by_role("option", name=access_level).click()


@given("The tables is not sort on table as default")
def no_sort_on_table_as_default(context):
    page: Page = context.page
    headers = page.locator("tr[role='row'][data-pc-section='root'] th")
    assert headers.count() > 1
    for i in range(1, headers.count()):
        assert headers.nth(i).get_attribute('aria-sort') == "none"


@when("I sort the table with '{column_name}' in ASC")
def sort_by_column_in_asc(context, column_name):
    page: Page = context.page
    header = page.get_by_role("columnheader", name=column_name, exact=True)
    if header.get_attribute('aria-sort') == "none" or header.get_attribute('aria-sort') == "descending":
        header.click()
    assert header.get_attribute('aria-sort') == "ascending"


@given("I sort the table with '{column_name}' in DESC")
@when("I sort the table with '{column_name}' in DESC")
def sort_by_column_in_desc(context, column_name):
    page: Page = context.page
    header = page.get_by_role("columnheader", name=column_name, exact=True)
    if header.get_attribute('aria-sort') == "none":
        header.click()
    if header.get_attribute('aria-sort') == "ascending":
        header.click()
    assert header.get_attribute('aria-sort') == "descending"


@when("I input '{filter_text}' to the filter box")
def filter_by_text_column(context, filter_text):
    page: Page = context.page
    input_box = page.get_by_placeholder("Filter")
    expect(input_box).to_be_visible()
    logger.info(f"Filtering the table with text {filter_text}")
    input_box.fill(filter_text)


@given("There is '{num_of_row}' rows in the table")
@then("There is '{num_of_row}' rows in the table")
def check_row_in_the_table(context, num_of_row):
    page: Page = context.page
    rows = wait_for_rows_to_loaded(page)
    if rows.nth(0).inner_text() == CONSTANTS.NO_ROWS_TO_DISPLAY:
        assert 0 == int(num_of_row)
    else:
        assert rows.count() == int(num_of_row)


@given("Save the name of the newest Controller backup")
def save_the_name_of_the_newest_backup(context):
    page: Page = context.page
    page.wait_for_selector(LOCATOR.TABLE_HEADER, timeout=5000)
    rows = wait_for_rows_to_loaded(page)
    assert rows.count() >= 1
    if rows.count() == 1 and rows.nth(0).inner_text() == CONSTANTS.NO_ROWS_TO_DISPLAY:
        context.newest_backup_before_test = ""
        logger.info("There is no backup in the table")
    else:
        context.newest_backup_before_test = rows.nth(0).locator('td').nth(1).inner_text()
        logger.info(f"The newest backup before test is {context.newest_backup_before_test}")


@when("A dialog shown '{dialog_header}' on the page")
def seen_a_dialog_with_header(context, dialog_header):
    page: Page = context.page
    page.get_by_text(dialog_header, exact=True).wait_for(state="visible", timeout=10000)
    page.get_by_label("Close").click()
    # make sure the confirm dialog is closed
    page.get_by_text(dialog_header, exact=True).wait_for(state="hidden", timeout=5000)


@then("There is a new Controller Backup")
def there_is_a_new_controller_backup(context):
    page: Page = context.page
    rows = wait_for_rows_to_loaded(page)
    assert rows.count() >= 1
    assert rows.nth(0).inner_text() != CONSTANTS.NO_ROWS_TO_DISPLAY
    newest_backup_after_test = rows.nth(0).locator('td').nth(1).inner_text()
    logger.info(f"The newest backup after test is {context.newest_backup_before_test}")
    assert context.newest_backup_before_test != newest_backup_after_test


@then("The backup show up in the table")
def check_upload_success(context):
    page: Page = context.page
    expect(page.get_by_text(CONSTANTS.DOWNLOAD_BACKUP_NAME)).to_be_visible()


@given("There is at less '{num_of_row}' rows in the table")
def check_minimum_rows_in_the_table(context, num_of_row):
    num_of_row = int(num_of_row)
    page: Page = context.page
    page.wait_for_selector(LOCATOR.TABLE_HEADER, timeout=5000)
    rows = wait_for_rows_to_loaded(page)

    logger.info(f"{rows.count()} row found from table")
    if num_of_row < 0:
        assert False
    elif num_of_row == 0 and rows.count() == 1:
        assert rows.nth(0).inner_text() == CONSTANTS.NO_ROWS_TO_DISPLAY
    elif num_of_row == 1 and rows.count() == 1:
        assert rows.nth(0).inner_text() != CONSTANTS.NO_ROWS_TO_DISPLAY
    else:
        assert rows.count() >= num_of_row


@then("There is a button with '{button_name}' label")
def there_is_a_button_with_label(context, button_name):
    page: Page = context.page
    page.get_by_label(button_name, exact=True).is_visible()


@then("The Controller Backup is been deleted")
def the_backup_is_deleted(context):
    page: Page = context.page
    assert context.newest_backup_before_test
    # make sure the confirm dialog is closed
    page.locator("div.p-dialog").wait_for(state="hidden", timeout=5000)

    logger.info(f"The newest backup before test is {context.newest_backup_before_test}")
    rows = wait_for_rows_to_loaded(page)

    assert rows.count() >= 1
    # if there still have backup left
    if rows.count() > 1 or rows.nth(0).inner_text() != CONSTANTS.NO_ROWS_TO_DISPLAY:
        newest_backup_after_test = rows.nth(0).locator('td').nth(1).inner_text()
        logger.info(f"The newest backup after test is {context.newest_backup_before_test}")
        assert context.newest_backup_before_test != newest_backup_after_test
        assert CONSTANTS.DOWNLOAD_BACKUP_NAME != newest_backup_after_test


@then("The '{column_type}' under the '{column_name}' is in '{order_type}' order")
def check_order_of_first_row(context, column_type, column_name, order_type):
    fist_data = select_row_from_table(context, 0, column_name)
    second_data = select_row_from_table(context, 1, column_name)
    if column_type == "number":
        fist_data = int(fist_data.replace(",", ""))
        second_data = int(second_data.replace(",", ""))
    elif column_type == "hex":
        fist_data = int(fist_data, 16)
        second_data = int(second_data, 16)
    elif column_type == "option-hex":
        fist_data = 0 if fist_data == "" else int(fist_data, 16)
        second_data = 0 if second_data == "" else int(second_data, 16)
    elif column_type == "datetime":
        fist_data = datetime.strptime(fist_data, '%Y-%m-%d %H:%M:%S')
        second_data = datetime.strptime(second_data, '%Y-%m-%d %H:%M:%S')
    logger.info(f"{fist_data=}, {second_data=}")
    if order_type == "ASC":
        assert fist_data <= second_data
    elif order_type == "DESC":
        assert fist_data >= second_data
    else:
        logger.error(f"Unknown {order_type=}")
        assert False


@then("All displayed rows contain '{filter}'")
def check_all_rows_contain_filter(context, filter):
    page: Page = context.page
    rows = wait_for_rows_to_loaded(page)
    if rows.count() > 1 or rows.nth(0).inner_text() != CONSTANTS.NO_ROWS_TO_DISPLAY:
        for i in range(rows.count()):
            assert filter in rows.nth(i).inner_text()


@when("I choose '{mode}' mode from the dropdown")
def change_controller_mode(context, mode):
    page: Page = context.page
    page.locator("div#mode .p-dropdown-trigger").click()
    page.get_by_role("option", name=mode).click()


@then("Controller becomes '{mode}'")
def check_controller_mode(context, mode):
    page: Page = context.page
    general_section = get_form_section_by_name(page, "General")
    assert general_section
    expect(general_section.get_by_text(mode)).to_be_visible()
    if mode == "Online":
        page.wait_for_timeout(5000)


@given("I fill the '{field_type}' field '{field_name}' with '{value:String}' under '{section_name}'")
@when("I fill the '{field_type}' field '{field_name}' with '{value:String}' under '{section_name}'")
def fill_field_with_value(context, field_type, field_name, value, section_name):
    page: Page = context.page
    section = get_form_section_by_name(page, section_name)
    wait_until_page_loaded(page)
    assert section
    if field_type == "text":
        field = section.get_by_label(field_name, exact=True)
        field.fill(value)
    elif field_type == "number":
        field = section.get_by_role("row", name=field_name).get_by_role("spinbutton")
        field.fill(value)
        field.press("Enter")
    else:
        logger.error(f"Invalid field type '{field_type}'")
        assert False


@then("I am '{action}' to press the '{button_name}' button")
def check_is_button_clickable(context, action, button_name):
    page: Page = context.page
    button = page.get_by_label(button_name, exact=True)
    if action == "able":
        assert 'p-disabled' not in button.get_attribute('class')
    elif action == "unable":
        logger.info(button.get_attribute('class'))
        assert 'p-disabled' in button.get_attribute('class')
    else:
        assert False


@given("There is a link to the '{app_name}' on status bar")
@then("There is a link to the '{app_name}' on status bar")
def show_link_to_other_app(context, app_name):
    page: Page = context.page
    status_bar = page.locator('div.status_bar')
    page.get_by_text("Status Active").wait_for(timeout=30000)

    expect(status_bar).to_be_visible()
    context.link_to_other_app = status_bar.get_by_role("link", name=app_name)


@when("I press the '{link_name}' link on status bar")
def press_a_link_and_expect_new_page(context, link_name):
    page: Page = context.page
    status_bar = page.locator('div.status_bar')
    with page.expect_popup() as new_page_info:
        status_bar.get_by_text(link_name, exact=True).click()
    context.new_page = new_page_info.value


@then("I got in a new page which is '{page_name}' page")
def show_help_page(context, page_name):
    assert context.new_page
    expect(context.new_page).to_have_url(re.compile(fr".*\/{page_name}"))


@given("I press the '{link_name}' link")
@when("I press the '{link_name}' link")
def press_a_link_with_text(context, link_name):
    page: Page = context.page
    page.get_by_role("link", name=link_name).click()


@when("I press the About link")
def click_about_link(context):
    page: Page = context.page
    page.get_by_text("About", exact=True).click()


@then("The Administration App is shown")
def show_admin_app(context):
    page: Page = context.page
    expect(page).to_have_url(re.compile(r".*\/admin"))


@then("The About dialog is shown")
def show_about_dialog(context):
    page: Page = context.page
    expect(page.get_by_role("dialog")).to_be_visible()


@when("I press the Help link")
def press_the_help_link(context):
    page: Page = context.page
    with page.expect_popup() as new_page_info:
        page.get_by_text("Help", exact=True).click()
    context.new_page = new_page_info.value


@then("I got a toast show '{msg}'")
def error_toast_shown(context, msg):
    page: Page = context.page
    wait_until_page_loaded(page)
    expect(page.get_by_role("alert")).to_be_visible()
    assert msg in page.get_by_role("alert").inner_text()
    if msg == "Updated":
        page.wait_for_timeout(5000)


@then("There is '{available_button}' button")
def check_button_exists(context, available_button):
    page: Page = context.page
    if available_button == "Upload":
        expect(page.locator("span").filter(has_text=available_button).nth(1)).to_be_visible()
    else:
        expect(page.get_by_role("button", name=available_button, exact=True)).to_be_visible()


@then("There is no '{available_button}' button")
def check_button_not_exists(context, available_button):
    page: Page = context.page
    if available_button == "Upload":
        assert page.locator("span").filter(has_text=available_button).nth(1).count() == 0
    else:
        assert page.get_by_role("button", name=available_button, exact=True).count() == 0


@then("I can see my '{access_level}' in the title bar")
def check_access_level_in_title_bar(context, access_level):
    page: Page = context.page
    title_bar = page.locator(".title_bar")
    expect(title_bar.get_by_role("link", name=f"({access_level})")).to_be_visible()
