import re
from behave import given, when, then
from playwright.sync_api import Page, Locator, expect
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

    list_box = page.get_by_role("listbox")
    assert list_box, f"no list box popup after click on dropdown {field_name}"
    # To avoid tests running too fast, and last popup no closed yet
    if list_box.count() > 1:
        for i in range(list_box.count()):
            a_list_box = list_box.nth(i)
            if field_name in a_list_box.get_attribute("id"):
                list_box = a_list_box
                break
    list_box.get_by_role("option", name=option, exact=True).click()


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


@given("I can see the '{field_name}' is '{value}' under '{section_name}'")
@then("I can see the '{field_name}' is '{value}' under '{section_name}'")
def check_data_in_the_form(context, field_name, value, section_name):
    page: Page = context.page
    wait_until_page_loaded(page)
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


@when("I '{action}' on the check box '{field_name}' under '{section_name}' section")
def click_on_a_check_box(context, action, field_name: str, section_name):
    page: Page = context.page
    section = get_form_section_by_name(page, section_name)
    assert section, f"section {section_name} not found"

    check_box = section.get_by_role("row", name=field_name, exact=True).get_by_role("checkbox")
    assert check_box, f"no check box fond for field {field_name}"
    if action == "check":
        check_box.check()
    elif action == "uncheck":
        check_box.uncheck()
    else:
        assert False, f"unknown {action=}"


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
def select_data_in_a_list_box_from_the_form(context, value, field_name, section_name):
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
    assert menubar, "menubar not found"
    menubar.get_by_label(button_name, exact=True).click()


@when("There '{condition}' '{field_type}' field '{field_name}' under '{section_name}'")
@then("There '{condition}' '{field_type}' field '{field_name}' under '{section_name}'")
def check_field_whether_match_the_condition(context, condition, field_type, field_name, section_name):
    page: Page = context.page
    wait_until_page_loaded(page)
    section = get_form_section_by_name(page, section_name)
    assert section, f"{section_name=} not found"
    if field_type == "text":
        field = section.get_by_label(field_name, exact=True)
    elif field_type == "number":
        field = section.get_by_role("row", name=field_name).get_by_role("spinbutton")
    else:
        logger.error(f"Invalid field type '{field_type}'")
        assert False, f"Invalid {field_type=}"

    if condition == "is":
        expect(field).to_be_visible()
    elif condition == "is no":
        expect(field).not_to_be_visible()
    else:
        logger.error(f"Invalid condition '{condition}'")
        assert False, f"Invalid {condition=}"


@when("There '{condition}' dropdown '{dropdown_name}' under '{section_name}'")
@then("There '{condition}' dropdown '{dropdown_name}' under '{section_name}'")
def check_dropdown_whether_match_the_condition(context, condition, dropdown_name: str, section_name):
    page: Page = context.page
    wait_until_page_loaded(page)
    section = get_form_section_by_name(page, section_name)
    assert section, f"{section_name=} not found"

    dropdown = section.locator(f"#{dropdown_name.replace(' ', '')}")
    if condition == "is":
        expect(dropdown).to_be_visible()
    elif condition == "is no":
        expect(dropdown).not_to_be_visible()
    else:
        logger.error(f"Invalid condition '{condition}'")
        assert False, f"Invalid {condition=}"


@when("I press the button with '{button_name}' label if it's not disable")
def press_a_button_with_label(context, button_name):
    page: Page = context.page
    button = page.get_by_label(button_name, exact=True)
    assert button, f"{button_name} is not exist"

    if button.is_enabled():
        button.click()
    else:
        logger.debug(f"{button_name} is disabled, skipping press")


@then("There is '{num_of_options}' options in the dropdown '{dropdown_name}' under '{section_name}'")
def check_number_of_options_under_a_dropdown(context, num_of_options, dropdown_name: str, section_name):
    page: Page = context.page
    wait_until_page_loaded(page)
    section = get_form_section_by_name(page, section_name)
    assert section, f"{section_name=} not found"

    dropdown = section.locator(f"#{dropdown_name.replace(' ', '')}")
    assert dropdown, f"dropdown {dropdown_name} not found"
    dropdown.click()

    dropdown_body = page.locator(f"#{dropdown_name.replace(' ', '')}_list")
    assert dropdown_body, f"{dropdown_name} dropdown popup not found"
    option_count = dropdown_body.locator("li").count()
    assert int(num_of_options) == option_count, f"expect {num_of_options} got {option_count}"


@when("I select section '{section_name}' on navbar")
def click_on_section_on_nav_bar(context, section_name):
    page: Page = context.page
    nav_bar = page.locator(".navigation_panel")
    assert nav_bar, "nav bar not found"

    section = nav_bar.locator("div").filter(has_text=re.compile(fr"^{section_name}$")).first
    assert section, f"section {section} not found"

    section.get_by_role("link", name=section_name).click()


# TODO: this should get removed after CNP25-4268
@given("I can see the '{field_name}' is '{value}'")
@then("I can see the '{field_name}' is '{value}'")
def check_data_in_the_form_temp(context, field_name, value):
    page: Page = context.page
    wait_until_page_loaded(page)

    setting_items = page.locator(".setting-item")
    text = None
    for i in range(0, setting_items.count()):
        setting_item = setting_items.nth(i)
        if setting_item.locator(".title").inner_text() == field_name:
            text = setting_item.locator(".value").inner_text()
    assert text, f"field {field_name} not found"
    assert text == value, f"expect {field_name} got {value}"
