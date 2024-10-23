from behave import when, then
from playwright.sync_api import Page, Locator
from features.logger import logger
from features.steps.controller_common import LOCATOR, get_form_section_by_name, wait_until_page_loaded


# ***********************************************************
# *                     Util Functions                      *
# ***********************************************************
def get_list_box_from_a_form_section(section: Locator, field_name):
    rows = section.locator("tr")
    for i in range(0, rows.count()):
        row = rows.nth(i)
        if row.locator("td").count() == 2 and row.locator("td").first.inner_text() == field_name:
            return row.locator("td").nth(1).locator(".p-listbox-list")


# ***********************************************************
# *                          Steps                          *
# ***********************************************************
@when("I choose '{option}' option from the '{field_name}' dropdown under '{section_name}' section")
def select_from_a_dropdown(context, option, field_name: str, section_name):
    page: Page = context.page
    wait_until_page_loaded(page)
    section = get_form_section_by_name(page, section_name)
    assert section, f"section {section_name} not found"
    section.locator(f"#{field_name.replace(' ', '')}").click()
    page.get_by_role("option", name=option, exact=True).click()


@when("I click on the text in row '{row_num}' and column '{column_name}'")
def click_text_by_row_and_column(context, row_num, column_name):
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
    assert column_index >= 0, f"column {column_name} not found"

    columns = page.locator(f"tr[data-p-index='{row_num}'] td")
    link = columns.nth(column_index).locator(".pointer")
    logger.debug(f"Click on a link with text: {link.inner_html()}")
    link.click()


@then("I can see the '{field_name}' is '{value}' under '{section_name}'")
def check_data_in_the_form(context, field_name, value, section_name):
    page: Page = context.page
    section = get_form_section_by_name(page, section_name)
    assert section, f"section {section_name} not found"

    text = None
    rows = section.locator("tr")
    for i in range(0, rows.count()):
        row = rows.nth(i)
        if row.locator("td").count() == 2 and row.locator("td").first.inner_text() == field_name:
            text = row.locator("td").nth(1).inner_text()
    logger.debug(f"{text} == {value}")
    assert text == value, f"expect {value} got {text}"


@when("I click on the check box '{field_name}' under '{section_name}' section")
def click_on_a_check_box(context, field_name: str, section_name):
    page: Page = context.page
    section = get_form_section_by_name(page, section_name)
    assert section, f"section {section_name} not found"
    section.locator(f"#{field_name.replace(' ', '')}").click()


@then("I can see the '{field_name}' list box contain '{value}' under '{section_name}' section")
def check_data_in_a_list_box_from_the_form(context, field_name, value, section_name):
    page: Page = context.page
    section = get_form_section_by_name(page, section_name)
    assert section, f"section {section_name} not found"

    list_box = get_list_box_from_a_form_section(section, field_name)
    assert list_box, f"list box {field_name} not found"

    logger.debug(f"Texts in list box: {list_box.inner_text()}")
    assert value in list_box.inner_text(), f"{value} not in list box"


@when("I select '{value}' from the '{field_name}' list box under '{section_name}' section")
def select_data_in_a_list_box_from_the_form(context, value, field_name,  section_name):
    page: Page = context.page
    section = get_form_section_by_name(page, section_name)
    assert section, f"section {section_name} not found"

    list_box = get_list_box_from_a_form_section(section, field_name)
    assert list_box, f"list box {field_name} not found"

    list_box.get_by_label(value).click()


@when("I click '{button_name}' from menu bar")
def click_button_from_menu_bar(context, button_name):
    page: Page = context.page
    menubar = page.get_by_role("menubar")
    assert menubar, f"menubar not found"
    menubar.get_by_label(button_name, exact=True).click()