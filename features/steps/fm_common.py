import json
from time import sleep
from behave import when
from features.logger import logger
from features.steps.common import button_click
from playwright.sync_api import TimeoutError


@when("I clicked on FM {submenu} menu")
def navigating_pages(context, submenu):
    """
    To open a page in the Fleet Manager app
    """

    menu_dict = {
        "Subscribers": 1,
        "Subscriber RFSS Map": 1,
        "Groups": 2,
        "Groups RFSS Map": 2,
        "Supergroups": 3,
        "Locations": 4,
        "Service Areas": 4,
        "SN Contexts": 5,
        "IP Address Pool": 5,
        "DAC Group Profiles": 5,
        "DAC Group Map": 5,
        "Users": 6,
        "Console Users": 6,
        "Authentication": 6,
        "Fleet Backups": 7,
        "Users Backups": 7,
        "Change Logs Backups": 7,
        "Access Logs": 8,
        "Change Logs": 8,
        "Subscribers Import": 9,
        "Groups Import": 9,
    }

    link_url_dict = {
        "Subscribers": "/p25fm/subscribers",
        "Subscriber RFSS Map": "/p25fm/subscribers/rfss",
        "Groups": "/p25fm/groups",
        "Groups RFSS Map": "/p25fm/groups/rfss",
        "Supergroups": "/p25fm/supergroups",
        "Locations": "/p25fm/locations",
        "Service Areas": "/p25fm/service_areas",
        "SN Contexts": "/p25fm/service_areas",
        "IP Address Pool": "/p25fm/packetdata/ip",
        "DAC Group Profiles": "/p25fm/packetdata/dacgroups",
        "DAC Group Map": "/p25fm/packetdata/dacgroups/maps",
        "Users": "/p25fm/credentials/users",
        "Console Users": "/p25fm/credentials/consoleusers",
        "Authentication": "/p25fm/credentials/authentication",
        "Fleet Backups": "/p25fm/backups",
        "Users Backups": "/p25fm/backups/users",
        "Change Logs Backups": "/p25fm/backups/changelogs",
        "Access Logs": "/p25fm/logs/accesslogs",
        "Change Logs": "/p25fm/logs/changelogs",
        "Subscribers Import": "/p25fm/import/subscribers",
        "Groups Import": "/p25fm/import/groups",
    }

    menu_num = menu_dict[submenu]
    url = link_url_dict[submenu]

    # 1. Expanding Menus
    # if Subscribers, then no need to click since submenus, Subscribers is displayed already
    if menu_num != 1:
        # 3.30:
        # active_menu = context.page.locator(f'xpath=//*[@id="app"]/div[2]/div[2]/div[1]/div/div[{menu_num}]/div[2]/div/
        # span[2]')
        # 3.32:
        active_menu = context.page.locator(
            f'xpath=//*[@id="resizer"]/div[1]/div/div/div[{menu_num}]/div[2]/div/span[2]'
        )
        active_menu.click()
        sleep(2)

    # 2. Click the submenus
    link = context.page.locator(f'a[href="{url}"]')
    link.click()
    sleep(2)


def load_testcase_json(context, test_case):
    """"""

    file_mapping = {
        "Supergroup": "supergroup.json",
        "Subscriber": "subscribers.json",
        "User": "users.json",
        "DAC Group": "areas_dac.json",
        "Group": "groups.json",
        "Service": "areas_dac.json"
    }

    for key, file_name in file_mapping.items():
        if key in test_case:
            logger.info(f'{key}, {file_name}')
            with open(f"features/steps/data/fleet-manager/{file_name}") as json_data:
                return json.load(json_data)


def load_json_data(context, test_case):

    data = load_testcase_json(context, test_case)
    form_data = data[test_case]
    return form_data


def verify_data_exist(context, test_case):
    """"""
    if "Edit" in test_case:
        button_click(context, "Back")

    search_key = find_search_key(context, test_case)
    sleep(1)

    table = context.page.query_selector("table.p-datatable-table")
    sleep(1)

    rows = table.query_selector_all("tr")
    sleep(1)

    found = False

    for row in rows:
        cells = row.query_selector_all("td")
        for cell in cells:
            cell_text = cell.inner_text().strip()
            if search_key in cell_text:
                logger.info(f"Found! The {search_key} data is in the table.")
                found = True
                break
        if found:
            break
    return found


def find_search_key(context, test_case):

    if "Split" in context.scenario.name:
        return str(context.max_1stgroup)

    elif "Delet" in context.scenario.name:
        return context.value

    elif "Upload" in test_case:
        if "Group" in test_case:
            # one of the group ID in the file
            return "7006"
        else:
            # one of the  SUID in the file
            return "70006"
    elif "Member" in test_case:
        return context.member

    else:
        form_data = load_json_data(context, test_case)

        key_map = {
            "Import": "Start ID",
            "RFSS Map": "Maximum",
            "Supergroup": "Alias",
            "Create Group": "Group ID",
            "Create Announcement Group": "Group ID",
            "Edit Group": "Alias",
            "Create Subscriber": "Unit ID",
            "Edit Subscriber": "Alias",
            "User": "Name",
            "Service Area": "Area Name",
            "DAC Group Profile": "Name",
            "DAC Group Map": "Alias"

        }

        data_key = None
        for key in key_map:
            logger.info(f'{key}, {data_key}')
            if key in test_case:
                data_key = key_map[key]
                break

        if data_key:
            return form_data.get(data_key)


def get_file_names(context):

    table = context.page.query_selector("table.p-datatable-table")
    rows = table.query_selector_all("tr")
    backup_files = []

    for row in rows:
        first_td = row.query_selector('td:first-child')
        if first_td:
            backup_files.append(first_td.text_content().strip())

    return backup_files


def fill_field(context, selector, value):
    field = context.page.locator(selector)
    field.clear()
    field.fill(value)


def select_dropdown(context, dropdown_selector, option_value):
    dropdown = context.page.locator(dropdown_selector)
    dropdown.click()
    context.page.locator(f'li[aria-label="{option_value}"]').click()


def toggle_checkbox(checkbox, should_check):
    if checkbox.is_checked() != should_check:
        checkbox.click()


def click_save_button(context):
    save_buttons = [
        context.page.locator(".p-button-label:has-text('Save')").nth(0),
        context.page.locator(".p-button-label:has-text('Save')").nth(1),
        context.page.locator(".p-button-label:has-text('Save')").nth(2)
    ]

    for save_button in save_buttons:
        try:
            save_button.wait_for(state='visible', timeout=1000)
            save_button.click()
            break
        except TimeoutError:
            continue

    else:
        raise Exception(
            "No 'Save' button was clickable after trying all available options.")
