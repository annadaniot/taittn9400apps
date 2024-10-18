from pathlib import Path
import sys
from playwright.sync_api import sync_playwright
import os
import re

from util.constants import TaitFileName, RemoteFilePath, get_sql_file_path_by_tag
from util.ssh import copy_remote_to_local, copy_local_to_remote, run_command_over_ssh
from features.logger import logger

TEMPDIR = Path(__file__).parent.parent.joinpath("temp")
DATA_DIR = Path(__file__).parent.joinpath("steps").joinpath("data")
RM_BASE_CMD = "/usr/local/sbin/taitnet-p25rfss-mysql -c /home/taitnet/p25rc/config/secrets/.my.cnf -g _root"


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
        ip = context.config.userdata.get("rfss_ip", None)
        if ip is None:
            logger.error("RFSS-Controller UI test require 'rfss_ip' defined, exits")
            sys.exit()
        backup_dir = TEMPDIR.joinpath("rfss-controller").joinpath("backup")
        backup_dir.mkdir(parents=True, exist_ok=True)
        data_dir = DATA_DIR.joinpath("rfss-controller")
        if TaitFileName.AUTH_DB in feature.tags:
            logger.info(f"================ Backup {TaitFileName.AUTH_DB} ================")
            copy_remote_to_local(RemoteFilePath.AUTH_DB_PATH, backup_dir, ip)
            copy_local_to_remote(data_dir.joinpath(TaitFileName.AUTH_DB), RemoteFilePath.AUTH_DB_PATH, ip)
        if TaitFileName.P25RC_DB in feature.tags:
            logger.info(f"================ Backup {TaitFileName.P25RC_DB} ================")
            copy_remote_to_local(RemoteFilePath.P25RC_DB_PATH, backup_dir, ip)
            copy_local_to_remote(data_dir.joinpath(TaitFileName.P25RC_DB), RemoteFilePath.P25RC_DB_PATH, ip)

    elif "RFSS-Manager" in feature.tags:
        ip = context.config.userdata.get("rfss_ip", None)
        if ip is None:
            logger.error("RFSS-Controller UI test require 'rfss_ip' defined, exits")
            sys.exit()
        backup_dir = TEMPDIR.joinpath("rfss-manager").joinpath("backup")
        backup_dir.mkdir(parents=True, exist_ok=True)
        data_dir = DATA_DIR.joinpath("rfss-manager")

        if TaitFileName.CONFIGURE_DB in feature.tags:
            logger.info(f"================ Backup {TaitFileName.CONFIGURE_DB} ================")
            run_command_over_ssh(ip, f"{RM_BASE_CMD} -f /tmp/{TaitFileName.BACKUP_CONFIGURE_DB} backup configure")
            copy_remote_to_local(f"/tmp/{TaitFileName.BACKUP_CONFIGURE_DB}", backup_dir, ip)
            copy_local_to_remote(data_dir.joinpath(get_sql_file_path_by_tag(feature.tags)), "/tmp", ip)
            run_command_over_ssh(ip,
                                 f"{RM_BASE_CMD} -f /tmp/{get_sql_file_path_by_tag(feature.tags)} restore configure")

    elif "Site-Controller" in feature.tags:
        ip = context.config.userdata.get("site_ip", None)
        if ip is None:
            logger.error("Site-Controller UI test require 'site_ip' defined, exits")
            sys.exit()
        backup_dir = TEMPDIR.joinpath("site-controller").joinpath("backup")
        backup_dir.mkdir(parents=True, exist_ok=True)
        data_dir = DATA_DIR.joinpath("site-controller")
        if TaitFileName.AUTH_DB in feature.tags:
            logger.info(f"================ Backup {TaitFileName.AUTH_DB} ================")
            copy_remote_to_local(RemoteFilePath.AUTH_DB_PATH, backup_dir, ip)
            copy_local_to_remote(data_dir.joinpath(TaitFileName.AUTH_DB), RemoteFilePath.AUTH_DB_PATH, ip)
        if TaitFileName.P25SC_DB in feature.tags:
            logger.info(f"================ Backup {TaitFileName.P25SC_DB} ================")
            copy_remote_to_local(RemoteFilePath.P25SC_DB_PATH, backup_dir, ip)
            copy_local_to_remote(data_dir.joinpath(TaitFileName.P25SC_DB), RemoteFilePath.P25SC_DB_PATH, ip)

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
        ip = context.config.userdata.get("rfss_ip")
        if TaitFileName.AUTH_DB in feature.tags:
            logger.info(f"================ Restore {TaitFileName.P25RC_DB} ================")
            copy_local_to_remote(backup_dir.joinpath(TaitFileName.AUTH_DB), RemoteFilePath.AUTH_DB_PATH, ip)
        if TaitFileName.P25RC_DB in feature.tags:
            logger.info(f"================ Restore {TaitFileName.P25RC_DB} ================")
            copy_local_to_remote(backup_dir.joinpath(TaitFileName.P25RC_DB), RemoteFilePath.P25RC_DB_PATH, ip)

    elif "RFSS-Manager" in feature.tags:
        backup_dir = TEMPDIR.joinpath("rfss-manager").joinpath("backup")
        ip = context.config.userdata.get("rfss_ip")
        if TaitFileName.CONFIGURE_DB in feature.tags:
            logger.info(f"================ Restore {TaitFileName.P25RC_DB} ================")
            copy_local_to_remote(backup_dir.joinpath(TaitFileName.BACKUP_CONFIGURE_DB), "/tmp", ip)
            run_command_over_ssh(ip, f"{RM_BASE_CMD} -f /tmp/{TaitFileName.BACKUP_CONFIGURE_DB} restore configure")

    elif "Site-Controller" in feature.tags:
        backup_dir = TEMPDIR.joinpath("site-controller").joinpath("backup")
        ip = context.config.userdata.get("site_ip")
        if TaitFileName.AUTH_DB in feature.tags:
            logger.info(f"================ Restore {TaitFileName.P25SC_DB} ================")
            copy_local_to_remote(backup_dir.joinpath(TaitFileName.AUTH_DB), RemoteFilePath.AUTH_DB_PATH, ip)
        if TaitFileName.P25SC_DB in feature.tags:
            logger.info(f"================ Restore {TaitFileName.P25SC_DB} ================")
            copy_local_to_remote(backup_dir.joinpath(TaitFileName.P25SC_DB), RemoteFilePath.P25SC_DB_PATH, ip)


def after_all(context):
    if context.page and not context.page.is_closed():
        context.page.close()
    if context.session:
        context.session.close()
    context.browser.close()
    context.playwright.stop()
    logger.info("################### ENDING BEHAVE TESTS ###################")
