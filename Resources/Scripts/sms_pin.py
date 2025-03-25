import requests
from bs4 import BeautifulSoup
import re
import time
from robot.api.deco import keyword

SMS_URL = "https://receive-smss.com/sms/447400029731/"


@keyword("Get SMS Verification Code")
def get_sms_verification_code(retries=3, wait_time=20):
    headers = {
        "User-Agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.88 Safari/537.36",
        "Accept": "application/json"
    }

    pin_pattern = re.compile(r"Your verification code:\s*(\d{4})")

    for attempt in range(retries):
        print(f"🔄 Attempt {attempt + 1}/{retries} - Fetching SMS messages...")
        response = requests.get(SMS_URL, headers=headers)
        response.raise_for_status()

        soup = BeautifulSoup(response.text, 'html.parser')
        messages = soup.find_all("div", class_="col-md-6 msgg")

        for message in messages:
            span = message.find("span")
            if span:
                full_text = span.get_text(strip=True)
                match = pin_pattern.search(full_text)
                if match:
                    pin_code = match.group(1)
                    print(f"✅ PIN Code Found: {pin_code}")
                    return pin_code

        if attempt < retries - 1:
            print(f"⏳ PIN code not found. Retrying in {wait_time} seconds...")
            time.sleep(wait_time)

    raise ValueError("❌ PIN code not found after multiple attempts.")


if __name__ == "__main__":
    get_sms_verification_code()