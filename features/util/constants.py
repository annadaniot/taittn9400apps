from pathlib import Path


class TaitFileName:
    AUTH_DB = "authentication.db"
    P25RC_DB = "tait_p25rc.db"


class RemoteFilePath:
    TAIT_HOME_DIR = Path("/home/taitnet")
    P25RC_HOME_DIR = TAIT_HOME_DIR.joinpath("p25rc")
    AUTH_DB_PATH = TAIT_HOME_DIR.joinpath(TaitFileName.AUTH_DB)
    P25RC_DB_PATH = P25RC_HOME_DIR.joinpath(TaitFileName.P25RC_DB)
