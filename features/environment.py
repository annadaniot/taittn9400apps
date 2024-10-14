from pathlib import Path
import sys
from playwright.sync_api import sync_playwright
from features.logger import logger
import os
import re
import paramiko
from scp import SCPClient
from util.constants import TaitFileName, RemoteFilePath

TEMPDIR = Path(__file__).parent.parent.joinpath("temp")
DATA_DIR = Path(__file__).parent.joinpath("steps").joinpath("data")


def create_ssh_client(ip, username="taitnet", password="tait", port=22):
    client = paramiko.SSHClient()
    client.load_system_host_keys()
    client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
    client.connect(ip, port=port, username=username, password=password)
    return client


def copy_local_to_remote(source, destination, ip):
    try:
        ssh = create_ssh_client(ip)
        with SCPClient(ssh.get_transport()) as scp:
            scp.put(source, destination)
            logger.debug(f"Transfer {source} to {destination} success.")
        ssh.close()
    except Exception as e:
        logger.error(f"Error: {e}")
        raise e


def copy_remote_to_local(source, destination, ip):
    try:
        ssh = create_ssh_client(ip)
        logger.info(source)
        logger.info(destination)
        with SCPClient(ssh.get_transport()) as scp:
            scp.get(source, destination)
            logger.debug(f"Transfer {source} to {destination} success.")
        ssh.close()
    except Exception as e:
        logger.error(f"Error: {e}")
        raise e


def sanitize_filename(filename):
    return re.sub(r'[^\w\-]', '_', filename)


def before_all(context):
    context.playwright = sync_playwright().start()
    headless = context.config.userdata.get("headless", None) is not None
    context.browser = context.playwright.chromium.launch(headless=headless, channel="chrome")
    context.session = context.browser.new_context(
        ignore_https_errors=True,
        viewport={"width": 1280, "height": 720}
    )
    context.page = context.session.new_page()
    logger.info("################### STARTING BEHAVE TESTS ###################")
    if context.config.userdata.get("rfss_ip", None) is None and context.config.userdata.get("site_ip", None) is None:
        logger.error("NO 'rfss_ip' and 'site_ip' defined, exits")
        sys.exit()


def before_feature(context, feature):
    logger.info('')
    logger.info('')
    if "RFSS-Controller" in feature.tags:
        if context.config.userdata.get("rfss_ip", None) is None:
            logger.error("RFSS-Controller UI test require 'rfss_ip' defined, exits")
            sys.exit()
        backup_dir = TEMPDIR.joinpath("rfss-controller").joinpath("backup")
        backup_dir.mkdir(parents=True, exist_ok=True)
        data_dir = DATA_DIR.joinpath("rfss-controller")
        if TaitFileName.AUTH_DB in feature.tags:
            logger.info(f"================ Backup {TaitFileName.AUTH_DB} ================")
            # Backup existing
            copy_remote_to_local(RemoteFilePath.AUTH_DB_PATH,
                                 backup_dir,
                                 context.config.userdata.get("rfss_ip"))
            # Install test_version
            copy_local_to_remote(data_dir.joinpath(TaitFileName.AUTH_DB),
                                 RemoteFilePath.AUTH_DB_PATH,
                                 context.config.userdata.get("rfss_ip"))
        if TaitFileName.P25RC_DB in feature.tags:
            logger.info(f"================ Backup {TaitFileName.P25RC_DB} ================")
            # Backup existing
            copy_remote_to_local(RemoteFilePath.P25RC_DB_PATH,
                                 backup_dir,
                                 context.config.userdata.get("rfss_ip"))
            # Install test_version
            copy_local_to_remote(data_dir.joinpath(TaitFileName.P25RC_DB),
                                 RemoteFilePath.P25RC_DB_PATH,
                                 context.config.userdata.get("rfss_ip"))
    logger.info(f"================ Starting Feature: {feature.name} ================")


def before_scenario(context, scenario):
    logger.info('')
    logger.info('')
    logger.info(f"************* Starting Scenario: {scenario.name} *************")

    if context.page.is_closed():
        context.page = context.session.new_page()
    context.tracing_dir = "traces"
    os.makedirs(context.tracing_dir, exist_ok=True)
    trace_filename = sanitize_filename(scenario.name) + ".zip"
    context.tracing_path = os.path.join(context.tracing_dir, trace_filename)
    context.session.tracing.start(screenshots=True, snapshots=True, sources=True)
    logger.info("Tracing started for scenario: " + scenario.name)


def after_scenario(context, scenario):
    logger.info(f"******* Ending Scenario: {scenario.name} ********")
    context.session.tracing.stop(path=context.tracing_path)
    logger.info("Tracing stopped for scenario: " + scenario.name)
    context.page.close()


def after_feature(context, feature):
    logger.info(f"================ Ending Feature: {feature.name} ================")
    if "RFSS-Controller" in feature.tags:
        backup_dir = TEMPDIR.joinpath("rfss-controller").joinpath("backup")
        if TaitFileName.AUTH_DB in feature.tags:
            logger.info(f"================ Restore {TaitFileName.P25RC_DB} ================")
            copy_local_to_remote(backup_dir.joinpath(TaitFileName.AUTH_DB),
                                 RemoteFilePath.AUTH_DB_PATH,
                                 context.config.userdata.get("rfss_ip"))
        if TaitFileName.P25RC_DB in feature.tags:
            logger.info(f"================ Restore {TaitFileName.P25RC_DB} ================")
            copy_local_to_remote(backup_dir.joinpath(TaitFileName.P25RC_DB),
                                 RemoteFilePath.P25RC_DB_PATH,
                                 context.config.userdata.get("rfss_ip"))


def after_all(context):
    if context.page and not context.page.is_closed():
        context.page.close()
    if context.session:
        context.session.close()
    context.browser.close()
    context.playwright.stop()
    logger.info("################### ENDING BEHAVE TESTS ###################")
