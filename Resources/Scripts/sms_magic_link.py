import requests
from bs4 import BeautifulSoup
from robot.api.deco import keyword
import time
import re

SMS_URL = "https://receive-smss.com/sms/447400029731/"


@keyword("Get SMS Magic Link From Mailinator")
def get_sms_magic_link():
    headers = {
        "User-Agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.88 Safari/537.36",
        "Accept": "application/json"
    }

    attempts = 5
    wait_time = 10

    link_pattern = re.compile(r"https://staging\.rightvybe\.com\S+")

    for attempt in range(attempts):
        response = requests.get(SMS_URL, headers=headers)
        response.raise_for_status()

        soup = BeautifulSoup(response.text, 'html.parser')
        messages = soup.find_all("div", class_="col-md-6 msgg")

        for message in messages:
            span = message.find("span")
            if span:
                full_text = span.get_text(strip=True)
                match = link_pattern.search(full_text)
                if match:
                    magic_link = match.group(0)
                    print(f"✅ Magic Link Found: {magic_link}")
                    return magic_link

        if attempt < attempts - 1:
            print(f"🔄 Link not found. trying {attempt + 1}/{attempts}, wait {wait_time} seconds...")
            time.sleep(wait_time)
    raise ValueError("❌ Magic link not found after 3 attempts.")


if __name__ == "__main__":
    get_sms_magic_link()