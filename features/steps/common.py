from time import sleep
from behave import given, when, then
from playwright.sync_api import Page, expect
from features.logger import logger
from features.steps.controller_common import logout


@given("I opened the '{app_name}'")
def open_webui_app(context, app_name):
    page: Page = context.page
    if app_name == "RFSS Controller":
        ip = context.config.userdata.get("rfss_ip", None)
        url = f"https://{ip}/p25rc/"
        logout_func = logout

    elif app_name == "Fleet Manager":
        ip = context.config.userdata.get("rfss_ip", None)
        url = f"https://{ip}/p25fm/"
        logout_func = fm_logout

    elif app_name == "RFSS Manager":
        ip = context.config.userdata.get("rfss_ip", None)
        url = f"https://{ip}/WebUI/"
        logout_func = logout

    elif app_name == "Site Controller":
        ip = context.config.userdata.get("site_ip", None)
        url = f"https://{ip}/p25sc/"
        logout_func = logout

    else:
        logger.error(f"Unknown app name: {app_name}")
        assert False, f"Unknown app name: {app_name}"

    page.goto(url, wait_until="networkidle")
    for _ in range(5):
        if page.locator('div.status_bar').is_visible():
            logger.info("User Already logged in, Start logout")
            logout_func(context)
            break
        elif page.get_by_text("WARNING! THIS SYSTEM IS RESTRICTED TO AUTHORIZED USERS ONLY!").is_visible():
            break
        page.wait_for_timeout(1000)
        page.reload(wait_until="networkidle")


@when("I logged in with the credential User: {user}, Password: {passw}")
def login(context, user, passw):
    sleep(1)
    context.page.locator('input[type="text"]').fill(user)
    context.page.locator('input[type="password"]').fill(passw)
    context.page.get_by_role("button", name="Login").click()


@then("Login is successful")
def login_success(context):
    page: Page = context.page
    expect(page.get_by_text("WARNING! THIS SYSTEM IS RESTRICTED TO AUTHORIZED USERS ONLY!")).not_to_be_visible()


@given("I clicked the logout button")
def fm_logout(context):
    sleep(2)
    context.page.get_by_text("Logout").click()


@when("I press the {button_text} button")
def button_click(context, button_text):
    """"""

    buttons = context.page.locator(".p-button-label")

    # Find and click the button with the exact text
    for button in buttons.element_handles():
        if button.inner_text().strip() == button_text:
            button.click()
            break
    sleep(1)


@when("I choose {condition} on the dialog box")
def confirmation_dialog_box(context, condition):
    """"""

    context.page.locator(".tait-modal")
    sleep(1)

    button_click(context, condition)


def pressing_shiftey_andhold(context):
    """
    To press the SHIFT key and holding it when selecting multiple records
    """
    context.page.keyboard.down("Shift")


def get_toast_message(context):
    """
    To get and return the toast message
    """
    toast_message_locator = context.page.locator(
        "body div.p-toast.p-component.p-toast-bottom-right.p-ripple-disabled div div div div.p-toast-message-text span"
    )
    sleep(1)

    toast_message = toast_message_locator.text_content()

    return toast_message
