from robot.api.deco import keyword
import random

_random_number = random.randint(100000, 999999)

@keyword("Get New Unique Email")
def get_new_unique_email():
    email_prefix = f"rv-at{_random_number}"
    email = f"{email_prefix}@rbtest.testinator.com"
    return email

@keyword("Get New Unique Email Prefix")
def get_new_unique_email_prefix():
    return f"rv-at{_random_number}"

if __name__ == "__main__":
    full_email = get_new_unique_email()
    email_prefix = get_new_unique_email_prefix()

    print(f"📧 Full email: {full_email}")
    print(f"🔹 Email prefix: {email_prefix}")
