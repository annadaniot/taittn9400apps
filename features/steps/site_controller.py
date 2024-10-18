from pathlib import Path
from behave import when, then
from playwright.sync_api import Page
from features.logger import logger
from features.steps.controller_common import CONSTANTS, wait_for_rows_to_loaded


# ***********************************************************
# *                        Constants                        *
# ***********************************************************
TEMPDIR = Path(__file__).parent.parent.parent.joinpath("temp").joinpath("site-controller")


# ***********************************************************
# *                     Util Functions                      *
# ***********************************************************
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
@when("I press the name of the newest SC backup")
def click_on_the_name_of_a_row(context):
    page: Page = context.page
    assert context.newest_backup_before_test

    logger.info(f"Downloading SC backup: {context.newest_backup_before_test}")
    with page.expect_download() as download_info:
        page.get_by_text(context.newest_backup_before_test, exact=True).click()
    download = download_info.value

    download_path = TEMPDIR.joinpath(CONSTANTS.DOWNLOAD_BACKUP_NAME)
    logger.info(f"Download path: {download_path}")
    download.save_as(download_path)


@then("The newest SC backup is get downloaded")
def check_newest_backup_is_downloaded(context):
    assert context.newest_backup_before_test
    download_backup = TEMPDIR.joinpath(CONSTANTS.DOWNLOAD_BACKUP_NAME)
    assert download_backup.is_file()


@when("I upload a SC backup file")
def upload_file(context):
    page: Page = context.page
    upload_backup = TEMPDIR.joinpath(CONSTANTS.DOWNLOAD_BACKUP_NAME)
    logger.info(f"Upload path: {upload_backup}")
    page.set_input_files("input[type='file']", upload_backup)


@when("I press the name of the first row on SC")
def click_on_the_name_of_first_row(context):
    page: Page = context.page
    rows = wait_for_rows_to_loaded(page)
    file_name = rows.nth(0).locator('td').nth(1).inner_text()

    logger.info(f"Downloading file: {file_name}")
    with page.expect_download() as download_info:
        page.get_by_text(file_name, exact=True).click()
    download = download_info.value

    download_path = TEMPDIR.joinpath(file_name)
    logger.info(f"Download path: {download_path}")
    download.save_as(download_path)
    context.download_file_name = file_name


@then("The first file is get downloaded from SC")
def check_the_file_is_downloaded(context):
    assert context.download_file_name
    download_backup = TEMPDIR.joinpath(CONSTANTS.DOWNLOAD_BACKUP_NAME)
    assert download_backup.is_file()
