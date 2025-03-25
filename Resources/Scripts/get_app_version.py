import requests
from requests.auth import HTTPBasicAuth
from robot.api.deco import keyword
from robot.libraries.BuiltIn import BuiltIn

# BrowserStack Credentials
BROWSERSTACK_USERNAME = BuiltIn().get_variable_value("${BROWSERSTACKUSERNAME}")
BROWSERSTACK_ACCESS_KEY = BuiltIn().get_variable_value("${BROWSERSTACKACCESSKEY}")

# API Endpoint
BROWSERSTACK_API_URL = "https://api-cloud.browserstack.com/app-automate/recent_apps/{}"


def fetch_latest_app_version(custom_id):
    """Generic function to fetch the latest app version for a given custom_id"""
    url = BROWSERSTACK_API_URL.format(custom_id)
    response = requests.get(url, auth=HTTPBasicAuth(BROWSERSTACK_USERNAME, BROWSERSTACK_ACCESS_KEY))

    if response.status_code != 200:
        raise Exception(
            f"Failed to fetch app version for {custom_id}. Status Code: {response.status_code}, Response: {response.text}")

    data = response.json()

    if not data or not isinstance(data, list):
        raise Exception(f"Invalid response format from BrowserStack API for {custom_id}")

    latest_version = data[0].get("app_version", "unknown")

    print(f"Latest App Version for {custom_id}: {latest_version}")
    return latest_version


@keyword("Get Android App Version")
def get_android_app_version():
    """Fetch latest version for Android app (RightVybe)"""
    return fetch_latest_app_version("RightVybe")


@keyword("Get iOS App Version")
def get_ios_app_version():
    """Fetch latest version for iOS app (RightVybeiOS)"""
    return fetch_latest_app_version("RightVybeiOS")

if __name__ == "__main__":
    get_android_app_version()
    get_ios_app_version()