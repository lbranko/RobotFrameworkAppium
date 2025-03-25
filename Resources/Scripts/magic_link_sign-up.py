import requests
import sys
from robot.api.deco import keyword

API_KEY = "9171eb8176dc4c4dad58a058948af13e"
DOMAIN = "rbtest.testinator.com"

@keyword("Get Latest Message ID For Sign-up")
def get_latest_message_id_sign_up(inbox):
    url = f"https://mailinator.com/api/v2/domains/{DOMAIN}/inboxes/{inbox}?token={API_KEY}"
    response = requests.get(url)

    if response.status_code != 200:
        raise ValueError(f"❌ Error retrieving inbox: {response.text}")

    data = response.json()
    messages = data.get("msgs", [])

    if not messages:
        raise ValueError("⚠️ No new emails.")

    latest_email = sorted(messages, key=lambda x: x["time"], reverse=True)[0]
    return latest_email["id"]

@keyword("Get Magic Link From Mailinator For Sign-up")
def get_link_from_mailinator_sign_up(inbox):
    message_id = get_latest_message_id_sign_up(inbox)
    print(f"📩 Latest Message ID: {message_id}")

    url = f"https://mailinator.com/api/v2/domains/{DOMAIN}/inboxes/{inbox}/messages/{message_id}/links?token={API_KEY}"
    response = requests.get(url)

    if response.status_code != 200:
        raise ValueError(f"❌ Error retrieving links: {response.text}")

    data = response.json()
    links = data.get("links", [])

    if not links:
        raise ValueError("⚠️ No links in the email.")

    print(f"✅ Magic Link: {links[0]}")
    return links[0]

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("❌ Usage: python script.py <INBOX>")
        sys.exit(1)

    inbox_name = sys.argv[1]
    get_link_from_mailinator_sign_up(inbox_name)
