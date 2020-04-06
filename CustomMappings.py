from datetime import datetime

mappings = {
    "Korea, South": "South Korea",
    "Republic of Korea": "South Korea",
    "Mainland China": "China",
    "Republic of Ireland": "Ireland",
    "The Bahamas": "Bahamas",
    "Bahamas, The": "Bahamas",
    "Viet Nam": "Vietnam",
    "UK": "United Kingdom",
    "Russian Federation": "Russia",
    "Hong Kong SAR": "Hong Kong",
    "Iran (Islamic Republic of)": "Iran",
    "occupied Palestinian territory": "Palestine",
    "Taiwan*": "Taiwan",
    "The Gambia": "Gambia",
    "Gambia, The": "Gambia",
    "Congo (Brazzaville)": "Republic of the Congo",
    "Congo (Kinshasa)": "Republic of the Congo",
    "Vatican City": "Holy See"
}


def mapcountry(country):
    for key in mappings.keys():
        country = country.replace(key, mappings[key])

    return country.strip()


def mapdate1(date):
    return datetime.strftime(datetime.strptime(date, '%m/%d/%Y %H:%M'), '%Y-%m-%d')


def mapdate2(date):
    return datetime.strftime(datetime.strptime(date, '%m/%d/%y %H:%M'), '%Y-%m-%d')


def mapdate3(date):
    return datetime.strftime(datetime.strptime(date, '%Y-%m-%dT%H:%M:%S'), '%Y-%m-%d')


def mapdate4(date):
    return datetime.strftime(datetime.strptime(date, '%Y-%m-%d %H:%M:%S'), '%Y-%m-%d')
