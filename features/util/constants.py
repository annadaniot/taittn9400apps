from pathlib import Path


class TaitFileName:
    AUTH_DB = "authentication.db"
    P25RC_DB = "tait_p25rc.db"
    P25SC_DB = "tait_p25sc.db"
    CONFIGURE_DB = "configure"
    BACKUP_CONFIGURE_DB = "playwright-configure.sql"


class RemoteFilePath:
    TAIT_HOME_DIR = Path("/home/taitnet")
    P25RC_HOME_DIR = TAIT_HOME_DIR.joinpath("p25rc")
    P25SC_HOME_DIR = Path("/opt/tait_p25sc/data/p25sc")
    AUTH_DB_PATH = TAIT_HOME_DIR.joinpath(TaitFileName.AUTH_DB)
    P25RC_DB_PATH = P25RC_HOME_DIR.joinpath(TaitFileName.P25RC_DB)
    P25SC_DB_PATH = P25SC_HOME_DIR.joinpath(TaitFileName.P25SC_DB)


def get_sql_file_path_by_tag(tags):
    if "empty" in tags:
        return "empty-configure-3.32.sql"
    elif "external-device" in tags:
        return "external-device-3.32.sql"
    elif "mobile-ip-home-agent" in tags:
        return "mhipa-configure-3.32.sql"
