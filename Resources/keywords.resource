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
    ...    platformName=iOS    deviceName=iPhone 14

Open Login Page
    Wait Until Page Contains Element    ${LOGIN.LOGIN}    timeout=30
    Click Element    ${LOGIN.LOGIN}
    Wait Until Page Contains Element    ${LOGIN.WELCOMEBACK}
    Sleep    5
