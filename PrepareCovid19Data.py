import os
import sys
from shutil import copyfile
from datetime import datetime, timedelta

BASE_INPUT_DIRECTORY = "../original-data/"
BASE_OUTPUT_DIRECTORY = "../prepared-data/"


def getversion(date):
    if date == datetime.strptime("01-22-2020", '%m-%d-%Y') or \
            date == datetime.strptime("01-31-2020", '%m-%d-%Y') or \
            date == datetime.strptime("02-01-2020", '%m-%d-%Y'):
        return "v1"
    elif date <= datetime.strptime("01-30-2020", '%m-%d-%Y'):
        return "v2"
    elif date <= datetime.strptime("02-29-2020", '%m-%d-%Y'):
        return "v3"
    elif date <= datetime.strptime("03-21-2020", '%m-%d-%Y'):
        return "v4"
    elif date == datetime.strptime("03-22-2020", '%m-%d-%Y'):
        return "v5"
    else:
        return "v6"


if __name__ == '__main__':
    from_date = datetime.strptime(sys.argv[1], '%m-%d-%Y')
    to_date = datetime.strptime(sys.argv[2], '%m-%d-%Y')
    one_day = timedelta(1)

    while from_date <= to_date:
        filename = "{}.csv".format(from_date.strftime("%m-%d-%Y"))
        inputFilename = "{}{}".format(BASE_INPUT_DIRECTORY, filename);
        outputDirectory = "{}{}/".format(BASE_OUTPUT_DIRECTORY, getversion(from_date));
        if not os.path.exists(os.path.dirname(outputDirectory)):
            os.makedirs(os.path.dirname(outputDirectory))

        outputFilename = "{}{}".format(outputDirectory, filename);

        copyfile(inputFilename, outputFilename)

        from_date += one_day
