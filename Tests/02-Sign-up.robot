*** Settings ***
Resource          ../Resources/keywords.resource
Suite Setup       Setup Action
Test Setup        Test Setup Action
Suite Teardown    Teardown Action


*** Test Cases ***
Sign up with new email
    Launch Mobile Application
    Register And Attempt Join Without Accepting Terms
    Register And Accept Terms And Join
    Get Email Magic Link And Open Deep Link For Sign-up
    Success Page
    Enter Phone Number And Continue
    Get SMS PIN And Enter
    Enter First And Last Name
    Onboarding Notification
    Referral Code Page
    Face ID Page
    Create Your PIN
    Confirm Your PIN
    Home Page
    Reopen App With Biometric
    Sign Out