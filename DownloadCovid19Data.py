from datetime import datetime, timedelta
import os
import requests;
import sys

BASE_URL = "https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_daily_reports/"
BASE_DIRECTORY = "../original-data/"

if __name__ == '__main__':
    from_date = datetime.strptime(sys.argv[1], '%m-%d-%Y')
    to_date = datetime.strptime(sys.argv[2], '%m-%d-%Y')
    one_day = timedelta(1)

    os.mkdir(BASE_DIRECTORY)

    while from_date <= to_date:
        filename = "{}.csv".format(from_date.strftime("%m-%d-%Y"))
        url = "{}{}".format(BASE_URL, filename)
        file = requests.get(url)
        open('{}{}'.format(BASE_DIRECTORY, filename), 'wb').write(file.content)
        print("Downloaded: " + url)
        from_date += one_day

    print("Downloaded all files.")
