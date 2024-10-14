import logging


class CustomFormatter(logging.Formatter):
    def format(self, record):

        # Create the custom info string with filename and line number
        info = f"{record.filename} [Line:{record.lineno}]"
        info = info.ljust(30)  # Adjust the total length as needed

        # Add the custom info to the record
        record.info = info

        # Call the base class format method
        return super().format(record)


def setup_logger(log_file_path='Tests.log'):
    logger = logging.getLogger('Scenario_logger')
    logger.setLevel(logging.INFO)

    # formatter = CustomFormatter('%(asctime)s | %(levelname)-8s | %(filename)s:%(lineno)d | %(message)s')
    formatter = CustomFormatter('%(asctime)s | %(levelname)-8s | %(info)s | %(message)s')
    file_handler = logging.FileHandler(log_file_path, mode='w')
    file_handler.setFormatter(formatter)

    logger.addHandler(file_handler)

    return logger


# Usage
logger = setup_logger()
