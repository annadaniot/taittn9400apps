import json
from time import sleep
from behave import when
from features.logger import logger
from features.steps.common import button_click


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
    logger.info(f"menu_num: {menu_num}")

    url = link_url_dict[submenu]
    logger.info(f"link: {url}")

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
    logger.info(f"testcase in load_jsonFile: {test_case}")

    if "Supergroup" in test_case:
        with open("features/steps/data/fleet-manager/supergroup.json") as json_data:
            return json.load(json_data)

    elif "Subscriber" in test_case:
        with open("features/steps/data/fleet-manager/subscribers.json") as json_data:
            return json.load(json_data)

    elif "User" in test_case:
        with open("features/steps/data/fleet-manager/users.json") as json_data:
            return json.load(json_data)       

    elif "Group" in test_case:
        with open("features/steps/data/fleet-manager/groups.json") as json_data:
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
    logger.info(f"searchKey: {search_key}")
    sleep(1)

    table = context.page.query_selector("table.p-datatable-table")
    sleep(1)

    rows = table.query_selector_all("tr")
    sleep(1)

    found = False

    for row in rows:
        # Select all cells within the current row
        cells = row.query_selector_all("td")
        for cell in cells:
            cell_text = cell.inner_text().strip()
            logger.info(cell_text)
            if search_key in cell_text:
                logger.info(f"Found! The {search_key} data is in the table.")
                found = True
                break
        if found:
            break
    return found


def find_search_key(context, test_case):

    logger.info(f"in searchkey, testcase is {test_case}")

    logger.info(context.scenario.name)

    if "Split" in context.scenario.name:
        logger.info(context.max_1stgroup)
        return str(context.max_1stgroup)

    elif "Delet" in context.scenario.name:
        logger.info(f"context.value: {context.value}")
        return context.value

    elif "Upload" in test_case:
        if "Group" in test_case:
            # one of the group ID in the file
            return "7006"
        else:
            # one of the  SUID in the file
            return "70006"

    else:
        form_data = load_json_data(context, test_case)

        if test_case == "Create Group":
            logger.info(f"{form_data['Group ID']}")
            return form_data["Group ID"]

        elif test_case == "Edit Group":
            logger.info(f"{form_data['Alias']}")
            return form_data["Alias"]

        elif "Groups Import" in test_case or "Subscribers Import" in test_case:
            logger.info(f"{form_data['Start ID']}")
            return form_data["Start ID"]

        elif test_case == "Create Subscriber":
            logger.info(f"{form_data['Unit ID']}")
            return form_data["Unit ID"]

        elif test_case == "Edit Subscriber":
            logger.info(f"{form_data['Alias']}")
            return form_data["Alias"]

        elif "RFSS Map" in test_case:
            logger.info(f"{form_data['Maximum']}")
            return form_data["Maximum"]

        elif 'User' in test_case:
            logger.info(f'{form_data["Name"]}')
            return form_data["Name"]
        
        elif 'Supergroup' in test_case:
            logger.info(f'{form_data["Alias"]}')
            return form_data["Alias"]
        else:
            logger.info(f'{test_case} not found.')


def get_file_names(context):

    table = context.page.query_selector("table.p-datatable-table")

    rows = table.query_selector_all("tr")

    backup_files = []

    for row in rows:
        first_td = row.query_selector('td:first-child')
        if first_td:  # Ensure there is a <td> element in the row
            backup_files.append(first_td.text_content().strip())

    return backup_files


