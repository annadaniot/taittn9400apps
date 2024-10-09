import os
import logging
from time import sleep
from behave import when, then
from features.logger import logger
from features.steps.common import (
    button_click,
    confirmation_dialog_box,
    get_toast_message,
    login,
    login_success,
    pressing_shiftey_andhold,
)
from features.steps.fm_common import get_file_names, load_json_data, navigating_pages, verify_data_exist


@when("I fill in the form with a {test_case} Scenario")
@when("I do {test_case}")
def edit_create_rfss_map(context, test_case):
    """
    Creates or Edit Subscriber or Group Home RFSS Map
    """
    form_data = load_json_data(context, test_case)

    logger.info(f"Data in the json file: {form_data}")

    wacn_id = context.page.locator("#wacnIdDec")
    wacn_id.fill(form_data["WACN ID"])

    sys_id = context.page.locator("#systemIdDec")
    sys_id.fill(form_data["System ID"])

    rfss_id = context.page.locator("#rfssIdDec")
    rfss_id.fill(form_data["RFSS ID"])

    alias = context.page.locator("#alias")
    alias.fill(form_data["Alias"])

    agency_dropdown = context.page.locator("#agencyName > div > svg")
    agency_dropdown.click()
    agency_json = form_data["Agency"]
    context.page.locator(f'li[aria-label="{agency_json}"]').click()

    if "Subscriber" in test_case:
        min_id = context.page.locator("#unitIdMinDec")
        max_id = context.page.locator("#unitIdMaxDec")

    else:
        min_id = context.page.locator("#groupIdMinDec")
        max_id = context.page.locator("#groupIdMaxDec")

        if form_data["Supergroup"] == "Yes":
            context.page.locator('#supergroup input').check()

    min_id.fill(form_data["Minimum"])

    max_id.fill(form_data["Maximum"])


@when("I complete the {test_case} form")
@when("I will do {test_case}")
def edit_create_groups(context, test_case):
    """
    Creates or Edit Groups
    """
    form_data = load_json_data(context, test_case)

    logger.info(f"Data in the json file: {form_data}")

    # Create single Group only
    if "Import" not in test_case:
        group_id = context.page.locator("#groupIdDec")
        group_id.clear()
        group_id.fill(form_data["Group ID"])

    # Create several Groups
    else:
        start_gid = context.page.locator("#startGroupIdDec")
        start_gid.clear()
        start_gid.fill(form_data["Start ID"])

        end_gid = context.page.locator("#endGroupIdDec")
        end_gid.clear()
        end_gid.fill(form_data["End ID"])

    alias = context.page.get_by_label("Alias")
    alias.clear()
    alias.fill(form_data["Alias"])
    if "Edit Group" in test_case:
        logger.info(f"Alias: {form_data['Alias']}")

    context.page.locator("#type div svg").click()
    context.page.get_by_role("option", name=form_data["Type"])

    context.page.locator("#membershipType").click()
    context.page.get_by_role("option", name=form_data["Membership"], exact=True).click()

    context.page.locator("#priority").click()
    context.page.locator(f'li[aria-label="{form_data["Priority"]}"]').click()

    rfhangtime = context.page.locator("#rfHangTime input")
    rfhangtime.clear()
    rfhangtime.fill(form_data["RF Hangtime"])

    emerhangtime = context.page.locator("#emHangTime input")
    emerhangtime.clear()
    emerhangtime.fill(form_data["Emergency Hangtime"])

    timeout = context.page.locator("#confirmedTimeout input")
    timeout.clear()
    timeout.fill(form_data["Timeout"])

    non_emer = context.page.locator("#allowNonEmergencyCalls input")
    emer = context.page.locator("#allowEmergencyCalls input")
    fdma_aff = context.page.locator("#allowFDMAAffiliation input")
    prior_talkgroup_scan = context.page.locator("#priorityTalkgroupScan input")

    if non_emer.is_checked() and form_data["Allow Non-Emergency"] == "No":
        non_emer.uncheck()
    if form_data["Allow Non-Emergency"] == "Yes":
        non_emer.check()

    if emer.is_checked() and form_data["Allow Emergency"] == "No":
        emer.uncheck()
    if form_data["Allow Emergency"] == "Yes":
        emer.check()

    if fdma_aff.is_checked() and form_data["Allow FDMA Affiliation"] == "No":
        fdma_aff.uncheck()
    if form_data["Allow FDMA Affiliation"] == "Yes":
        fdma_aff.check()

    if prior_talkgroup_scan.is_checked() and form_data["Priority TG Scan"] == "No":
        prior_talkgroup_scan.uncheck()
    if form_data["Priority TG Scan"] == "Yes":
        prior_talkgroup_scan.check()

    context.test_case = test_case


@when("I fill in the {test_case} form")
@when("I'll do the scenario {test_case}")
def edit_create_subscriber(context, test_case):
    """
    Creates or Edit Subscriber
    """
    form_data = load_json_data(context, test_case)

    logger.info(f"Data in the json file: {form_data}")

    # Create single SU only
    if "Import" not in test_case:
        unit_id = context.page.locator("#unitIdDec")
        unit_id.fill("")  # Clear the field by filling it with an empty string
        unit_id.fill(form_data["Unit ID"])

        allow_data_calls = context.page.locator(
            '//*[@id="app"]/div[1]/div/div/div[21]/div/div[2]/div/div[2]'
        )
        allow_data_json = form_data["Allow Data Calls"]
        if allow_data_json == "Yes":
            allow_data_calls.click()

    # Create several SUs only
    else:
        start_uid = context.page.locator("#startUnitIdDec")
        start_uid.fill(form_data["Start ID"])

        end_uid = context.page.locator("#endUnitIdDec")
        end_uid.fill(form_data["End ID"])

    alias = context.page.locator("#alias")
    alias.fill(form_data["Alias"])

    if "Create" in test_case:
        type_dropdown = context.page.locator("#type div svg")
        type_dropdown.click()
        type_json = form_data["Type"]
        context.page.locator(f'li[aria-label="{type_json}"]').click()

    unit_type_dropdown = context.page.locator("#unitType div svg")
    unit_type_dropdown.click()
    unit_type_json = form_data["Unit Type"]
    context.page.locator(f'li[aria-label="{unit_type_json}"]').click()

    priority_dropdown = context.page.locator("#priority div svg")
    priority_dropdown.click()
    priority_json = form_data["Priority"]
    context.page.locator(f'li[aria-label="{priority_json}"]').click()

    group_call_permission_dropdown = context.page.locator("#groupCallPerm div svg")
    group_call_permission_dropdown.click()
    group_call_permission_json = form_data["Group Call Permission"]
    context.page.locator(f'li[aria-label="{group_call_permission_json}"]').click()
    sleep(1)

    unit_call_permission_dropdown = context.page.locator("#unitCallPerm div")
    unit_call_permission_dropdown.click()
    unit_call_permission_json = form_data["Unit Call Permission"]
    context.page.locator(f'li[aria-label="{unit_call_permission_json}"]').click()
    sleep(1)

    pstn_call_permission_dropdown = context.page.locator("#pstnCallPerm div svg")
    pstn_call_permission_dropdown.click()
    pstn_call_permission_json = form_data["PSTN Call Permission"]
    context.page.locator(f'li[aria-label="{pstn_call_permission_json}"]').click()

    info = context.page.locator("#info")
    info.fill(form_data["Information"])

    if unit_type_json == "Unit":
        affiliate_anywhere = context.page.locator("#affiliateAnywhere input")
        affiliate_anywhere_json = form_data["Affiliate Anywhere"]
        if affiliate_anywhere_json == "Yes":
            affiliate_anywhere.click()


@then("the scenario {test_case} is successful")
def success(context, test_case):
    """"""
    # 1. Check the toast message
    # Groups/Subscribers Import do not have toast message when success
    if "Groups Import" not in test_case and "Subscribers Import" not in test_case:
        toast_message = get_toast_message(context)
        logger.info(f"toast message is: {toast_message}")

        assert (
            "OK" in toast_message or "Success" in toast_message
        ), f"Test failed: Unexpected toast message '{toast_message}'"

    # 2. Verify data existence
    verify_data_exist(context, test_case)


@when("I select row #{number} from the {test_case} table")
def select_record(context, number, test_case):

    context.number = number
    logger.info(f"test_case:{test_case}")

    if "RFSS Map" in test_case:
        selected_row = context.page.locator(f"xpath=//tr[{number}]/td[4]/div")
        selected_row.click()
    elif "Deleting a Supergroup" in context.scenario.name:
        selected_row = context.page.locator(f"xpath=//tr[{number}]/td[3]")
        selected_row.click()
    elif "Backup" in test_case or 'Users' in test_case or 'Supergroup' in test_case:
        selected_row = context.page.locator(f"xpath=//tr[{number}]/td[1]")
        selected_row.click()
    else:
        selected_row = context.page.locator(f"xpath=//tr[{number}]/td[3]")
        checkbox = context.page.locator(f"//tr[{number}]/td[1]/div/input")
        checkbox.click()

    context.value = selected_row.inner_text()
    logger.info(f"context.value:{context.value}")
    sleep(1)


@then("deleting that {test_case} is successful")
def verify_deleterecord(context, test_case):

    found = verify_data_exist(context, test_case)
    sleep(1)

    assert found is False, "Deletion NOT successful."


@when("I clicked on {test_case} section")
def click_section(context, test_case):

    if "Group Location Permissions" in test_case:
        context.page.locator(
            "xpath=/html/body/div[1]/div/div/div[3]/div[3]/div[2]/div/div[2]/div[21]/div[1]/div/div[1]/a"
        ).click()
    if "Subscriber Location Permissions" in test_case:
        context.page.locator(
            "xpath=/html/body/div[1]/div/div/div[3]/div[3]/div[2]/div/div[2]/div[25]/div[1]/div/div[1]/a"
        ).click()


@then("the {test_case} is restricted to that location")
def verify_restriction(context, test_case):
    """"""

    logger.info(context.value)

    # 2. find if attribute is uncheck
    logger.info(context.number)
    if "Group" in test_case:
        checkbox = context.page.locator(
            f"xpath=/html/body/div[1]/div/div/div[3]/div[3]/div[2]/div/div[2]/div[21]/div[1]/div/div[2]/div/div/div[1]/"
            f"table/tbody/tr[{context.number}]/td[1]/div/input"
        )
    if "Subscriber" in test_case:
        checkbox = context.page.locator(
            f"xpath=/html/body/div[1]/div/div/div[3]/div[3]/div[2]/div/div[2]/div[25]/div[1]/div/div[2]/div/div/div[1]/"
            f"table/tbody/tr[{context.number}]/td[1]/div/input"
        )

    # 3. return true if uncheck
    logger.info(checkbox.is_checked())
    assert not checkbox.is_checked(), "Checkbox is still checked after Save."


@when("I select the data from row #{start_row} to #{end_row} in the {test_case} table")
def delete_many(context, start_row, end_row, test_case):
    """
    To delete multiple subscribers or groups
    """
    start_row = int(start_row)
    end_row = int(end_row)

    for number in range(start_row, end_row + 1):
        select_record(context, number, test_case)
        pressing_shiftey_andhold(context)
        number = +1


@when(
    "I split the {test_case} into 2 maps with the first one having max Unit ID of {max}"
)
def split_map(context, test_case, max):
    """
    To split the Home RFSS Map into 2 maps
    """

    context.test_case = test_case

    context.max_1stgroup = int(max)

    logger.info(f"test_case in split: {test_case}")

    if "Group" in test_case:
        split_id = context.page.locator('input[placeholder="Group ID Split"]')
    else:
        split_id = context.page.locator('input[placeholder="Unit ID Split"]')

    split_id.fill(str(context.max_1stgroup))
    sleep(1)

    button_click(context, "Confirm Split")


@then("splitting into 2 maps is successful")
def verify_map_split(context):
    """
    To verify that split is successful
    """
    logging.info(f"testcase in verify Split: {context.test_case}")

    found_2nd_min = False

    found_2nd_min = verify_data_exist(context, context.test_case)

    assert found_2nd_min, "The data for the second split group is NOT found."


@when("I upload the {test_case} CSV file")
def upload_csv_file(context, test_case):
    """
    To upload a CSV file
    """

    if "Group" in test_case:
        file_path = "features/steps/data/FleetManager_GroupsImport_Data.csv"

    if "Subscriber" in test_case:
        file_path = "features/steps/data/FleetManager_SubscribersImport_Data.csv"

    logger.info(f"file_path:{file_path}")
    absolute_file_path = os.path.abspath(file_path)
    upload = context.page.locator('input[type="file"]')

    upload.set_input_files(absolute_file_path)
    logger.info("Uploaded file:", absolute_file_path)

    sleep(2)


@when("I click on the all checkbox")
def tick_all_checkbox(context):
    """"""
    context.page.locator(
        "xpath=/html/body/div[1]/div/div/div[3]/div[3]/div[2]/div/div/div[2]/table/thead/tr[2]/th[1]/div/input"
    ).click()
    sleep(1)


@when('I Create a {test_case} Backup')
def create_backup(context, test_case):

    if 'Fleet' in test_case:
        context.page.locator(f'a[href="/p25fm/backups"]')

    backup_files = get_file_names(context)
    context.initial_count = len(backup_files)

    button_click(context, 'Backup')
    confirmation_dialog_box(context, "OK")


@then('the table contains the newest {test_case} Backup')
def verify_backup_created(context, test_case):

    new_backup_files = get_file_names(context)
    files_count = len(new_backup_files)

    assert (context.initial_count + 1) == files_count, 'Failed in backup creation'


@when('I created {test_case} and added other changes to it by mistake')
def create_data(context, test_case):

    if "Group" in test_case:
        # creating groups
        navigating_pages(context, "Groups")
        button_click(context, "Create Many")
        edit_create_groups(context, "Create Groups Import")
        button_click(context, "Save")
        button_click(context, "Import All")
        confirmation_dialog_box(context, "Yes")
        button_click(context, "Finish")


@when('I restore the latest {test_case} Backup file')
def backup_restore(context, test_case):

    if 'Fleet' in test_case:
        context.page.locator(f'a[href="/p25fm/backups"]').click()

    context.page.click("table tr:nth-child(1) td:nth-child(1)")

    button_click(context, "Restore")
    confirmation_dialog_box(context, "OK")
    # wait time for the restore to process
    sleep(9)


@then('the previously correct data is now restored')
def restore_status(context):

    text = context.page.locator(".tait-modal").inner_text()
    logger.info(text)

    assert 'backup restored' in text, 'Restoring a backup is NOT succesful'


@when('download that latest backup file')
def download_backup(context):
    with context.page.expect_download() as download_info:
        context.page.get_by_label("Download").click()
        download = download_info.value

    context.download_dir = 'features/steps/data/fleet-manager/downloads/'

    download.save_as(os.path.join(context.download_dir, context.value))


@then('the file is in the downloads folder')
def verify_backup(context):

    file = context.value
    logger.info(file)
    file_path = f"{context.download_dir}/{file}"
    logger.info(file_path)

    assert file in file_path, 'The backup file is not downloaded.'

    os.remove(file_path)


@when('I fill out the {test_case} form')
def create_edit_user(context, test_case):

    form_data = load_json_data(context, test_case)

    if 'Create' in test_case:
        username = context.page.locator('#username')
        username.fill(form_data["Username"])

    name = context.page.locator('#name')
    name.fill(form_data["Name"])

    password = context.page.locator('#password input')
    password.fill(form_data["Password"])
    context.page.locator("#password_panel").click()

    confirm_password = context.page.locator('#confirm-password  input')
    confirm_password.fill(form_data["Password"])
    context.page.locator("#confirm-password_panel").click()

    comment = context.page.locator('#comment')
    comment.fill(form_data["Comment"])

    logger.info(form_data["Disabled"])
    if form_data["Disabled"] == "Yes":
        context.page.locator("#disabled").get_by_role("checkbox").check()

    else:
        if 'Console' not in test_case:
            if form_data["Fleet Administrator"] == "Yes":
                context.page.locator("#admin").get_by_role("checkbox").check()
        else:
            context.page.locator("#pv_id_47 > span").click()
            context.page.get_by_role("option", name=form_data["Default"], exact=True).click()


@when('I login using the new credential')
def new_credential_login(context):

    form_data = load_json_data(context, 'Create User')

    login(context, form_data["Username"], form_data["Password"])


@then('I am able to see the Fleet Manager home page')
def newc_login_success(context):

    form_data = load_json_data(context, 'Create User')

    user_in_webui = context.page.locator('//*[@id="app"]/div/div/div[2]/div/div[1]/a[1]').inner_text()

    logger.info(f'user_in_webui: {user_in_webui}')

    assert form_data['Name'] == user_in_webui, 'Login with new credential is not successful'


@when('I complete the form with a {test_case} scenario')
def create_edit_supergroup(context, test_case):

    form_data = load_json_data(context, 'Edit Supergroup')

    if 'Create' in test_case:
        form_data = load_json_data(context, 'Create Supergroup')

        group_id = context.page.locator('#groupIdDec')
        group_id.fill(form_data["Group ID"])

    alias = context.page.locator('#alias')
    alias.fill(form_data["Alias"])

    rfhangtime = context.page.locator('#rfHangTime input') 
    rfhangtime.fill(form_data["RF Hangtime"])

    context.page.locator("#priority").click()
    context.page.locator(f'li[aria-label="{form_data["Priority"]}"]').click()


@when('I {test_case} to the Supergroup')
def add_members_supergroup(context, test_case):

    button_click(context, test_case)

    if 'Visiting' in test_case:
        context.page.locator(f"xpath=//tr[1]/td[2]/div").nth(1).click()
    else:
        context.page.locator(f"xpath=//tr[1]/td[2]/div").click()

    button_click(context, "Add")

    close_button = context.page.locator('div.p-dialog-header button')
    close_button.click()
