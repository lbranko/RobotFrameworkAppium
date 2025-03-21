*** Settings ***
Documentation    Simple example using AppiumLibrary
Resource         objects.resource
Library          BuiltIn
Library          AppiumLibrary


*** Variables ***
${LOCAL_URL}     127.0.0.1:4723


*** Keywords ***
Launch Mobile Application
    Open Application    ${LOCAL_URL}    automationName=XCUITest    app=/Users/runner/Runner/Runner.app
    ...    platformName=iOS    udid=BF977AC9-F95D-4F48-A40D-ED622A729196

Open Login Page
    Wait Until Page Contains Element    ${LOGIN.LOGIN}    timeout=30
    Click Element    ${LOGIN.LOGIN}
    Wait Until Page Contains Element    ${LOGIN.WELCOMEBACK}
    Sleep    5
