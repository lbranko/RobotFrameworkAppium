*** Settings ***
Resource          ../Resources/keywords.resource
Suite Setup       Setup Action
Test Setup        Test Setup Action
Suite Teardown    Teardown Action


*** Test Cases ***
Login - reset PIN via Email
    Launch Mobile Application
    Login And Submit Email    rv-at539055@rbtest.testinator.com
    Get Email Magic Link And Open Deep Link
    Reset PIN Via Email
    Get Email Magic Link For Reset PIN And Open Deep Link
    Enter New PIN
    Confirm PIN
    Home Page
    Sign Out

Login with new PIN
    Login And Submit Email    rv-at539055@rbtest.testinator.com
    Get Email Magic Link And Open Deep Link
    Enter PIN
    Home Page
    Sign Out

Login - reset PIN via phone
    Login And Submit Email    rv-at539055@rbtest.testinator.com
    Get Email Magic Link And Open Deep Link
    Reset PIN Via Phone
    Get SMS Magic Link For Reset PIN And Open Deep Link
    Enter New PIN
    Confirm PIN
    Home Page
    Sign Out
