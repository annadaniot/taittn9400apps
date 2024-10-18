import paramiko
from scp import SCPClient

from features.logger import logger


def create_ssh_client(ip, username="taitnet", password="tait", port=22):
    client = paramiko.SSHClient()
    client.load_system_host_keys()
    client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
    client.connect(ip, port=port, username=username, password=password)
    return client


def copy_local_to_remote(source, destination, ip):
    try:
        client = create_ssh_client(ip)
        logger.info(f"scp from {source} to {destination}")
        with SCPClient(client.get_transport()) as scp:
            scp.put(source, destination)
            logger.debug(f"Transfer {source} to {destination} success.")
        client.close()
    except Exception as e:
        logger.error(f"Error: {e}")
        raise e


def copy_remote_to_local(source, destination, ip):
    try:
        client = create_ssh_client(ip)
        logger.info(f"scp from {source} to {destination}")
        with SCPClient(client.get_transport()) as scp:
            scp.get(source, destination)
            logger.debug(f"Transfer {source} to {destination} success.")
        client.close()
    except Exception as e:
        logger.error(f"Error: {e}")
        raise e


def run_command_over_ssh(ip, command):
    try:
        client = create_ssh_client(ip)
        _, stdout, stderr = client.exec_command(command)
        output = stdout.read().decode()
        error = stderr.read().decode()
        logger.info(f"{output=}")
        logger.error(f"{error=}.")
        client.close()
    except Exception as e:
        logger.error(f"Error: {e}")
        raise e
