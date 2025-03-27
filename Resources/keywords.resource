*** Settings ***
Documentation    Simple example using AppiumLibrary
Resource         objects.resource
Resource         devices.resource
Resource         passwords.resource
Library          BuiltIn
Library          OperatingSystem
Library          Collections
Library          AppiumLibrary
Library          Scripts/get_app_version.py
Library          Scripts/magic_link.py
Library          Scripts/magic_link_sign-up.py
Library          Scripts/sms_magic_link.py
Library          Scripts/sms_pin.py
Library          Scripts/unique_email.py


*** Variables ***
${REMOTE_URL}    http://${BROWSERSTACKUSERNAME}:${BROWSERSTACKACCESSKEY}@hub-cloud.browserstack.com/wd/hub
${LOCAL_URL}     127.0.0.1:4723
${ENV}    local
${PLATFORM}    Android
${APK_APP_PATH_LOCAL}    /Users/blukac/Documents/RightVybe/RightVybe-App-Flutter/build/app/outputs/flutter-apk/app-production-debug.apk
${APP_APP_PATH_LOCAL}    /Users/blukac/Documents/RightVybe/RightVybe-App-Flutter/build/ios/iphonesimulator/Runner.app
${BROWSERSTACK_PASSED}      SEPARATOR=${EMPTY}
...    browserstack_executor:
...    {"action": "setSessionStatus", "arguments": {"status": "passed", "reason": "Test case passed!"}}
${BROWSERSTACK_FAILED}      SEPARATOR=${EMPTY}
...    browserstack_executor:
...    {"action": "setSessionStatus", "arguments": {"status": "failed", "reason": "Test case failed!"}}
${BROWSERSTACK_BIOMETRIC_PASS}      SEPARATOR=${EMPTY}
...    browserstack_executor:
...    {"action": "biometric", "arguments": {"biometricMatch": "pass"}}
${BROWSERSTACK_BIOMETRIC_FAIL}      SEPARATOR=${EMPTY}
...    browserstack_executor:
...    {"action": "biometric", "arguments": {"biometricMatch": "fail"}}


*** Keywords ***
Launch Mobile Application
    Open Application    ${LOCAL_URL}    automationName=XCUITest    app=/home/runner/work/RobotFrameworkAppium/RobotFrameworkAppium/Runner.app
     ...    platformName=iOS    udid=BF977AC9-F95D-4F48-A40D-ED622A729196

Launch Mobile Application Cloud Android
    Open Application    ${REMOTE_URL}    app=RightVybe    name=${SUITE NAME}    browserstack.idleTimeout=360
    ...    platformName=Android    platformVersion=${ANDROID_OS_VERSION}    deviceName=${ANDROID_DEVICE}    interactiveDebugging=true
    ...    build=Android RightVybe - ${ANDROID_APP_VERSION}    browserstack.enableBiometric=true    projectName=RightVybe
    ...    autoGrantPermissions=true

Launch Mobile Application Cloud iOS
    Open Application    ${REMOTE_URL}    app=RightVybeiOS    name=${SUITE NAME}    browserstack.idleTimeout=360
    ...    platformName=iOS    platformVersion=${IOS_OS_VERSION}    deviceName=${IOS_DEVICE}    interactiveDebugging=true
    ...    build=iOS RightVybe - ${IOS_APP_VERSION}    browserstack.enableBiometric=true    projectName=RightVybe

Launch Mobile Application Local Android
    Open Application    ${LOCAL_URL}    automationName=UiAutomator2    app=${APK_APP_PATH_LOCAL}
    ...    platformName=Android    os_version=14    deviceName=emulator-5554

Launch Mobile Application Local iOS
    Open Application    ${LOCAL_URL}    automationName=XCUITest    app=${APP_APP_PATH_LOCAL}
    ...    platformName=iOS    os_version=16.4    udid=8D49C7ED-0F5D-4F35-A315-7DAED49091D0    deviceName=iPhone 14

Wait For And Click Element
    [Arguments]    ${INPUT}
    Wait Until Page Contains Element    ${INPUT}
    Click Element    ${INPUT}

Login And Submit Email
    [Arguments]    ${EMAIl}
    Wait Until Page Contains Element    ${LOGIN.LOGIN}    timeout=30
    Click Element    ${LOGIN.LOGIN}
    ${MAIL}    Set Variable If    '${PLATFORM}' == 'iOS'    ${LOGIN.EMAILIOS}    ${LOGIN.EMAIL}
    Wait For And Click Element    ${MAIL}
    Sleep    1
    Input Text    ${MAIL}    ${EMAIl}
    Wait For And Click Element    ${LOGIN.WELCOMEBACK}
    Wait For And Click Element    ${LOGIN.SENDLINK}
    Wait Until Page Contains Element    ${LOGIN.CHECKEMAIL}    timeout=60

Get Email Magic Link And Open Deep Link
    Sleep    10
    ${MAGIC_LINK}    Get Magic Link From Mailinator
    Go To Url    ${MAGIC_LINK}

Get Email Magic Link And Open Deep Link For Sign-up
    Sleep    10
    ${EMAILPREFIX}    Get New Unique Email Prefix
    ${MAGIC_LINK}    Get Magic Link From Mailinator For Sign-up    ${EMAILPREFIX}
    Go To Url    ${MAGIC_LINK}

Reset PIN Via Email
    Wait Until Page Contains Element    ${LOGIN.UNLOCK}
    Wait For And Click Element    ${LOGIN.RESETPINEMAIL}

Reset PIN Via Phone
    Wait Until Page Contains Element    ${LOGIN.UNLOCK}
    Wait For And Click Element    ${LOGIN.RESETPINPHONE}

Get Email Magic Link For Reset PIN And Open Deep Link
    Sleep    10
    ${MAGIC_LINK}    Get Magic Link From Mailinator
    Go To Url    ${MAGIC_LINK}

Get SMS Magic Link For Reset PIN And Open Deep Link
    Sleep    20
    ${MAGIC_LINK}    Get SMS Magic Link From Mailinator
    Go To Url    ${MAGIC_LINK}

Enter PIN
    Wait Until Page Contains Element    ${LOGIN.ENTERPIN}
    ${PIN}    Set Variable If    '${PLATFORM}' == 'iOS'    ${LOGIN.EMAILIOS}    ${LOGIN.EMAIL}
    Wait For And Click Element    ${PIN}
    Input Text    ${PIN}    0000
    Wait For And Click Element    ${LOGIN.UNLOCK}

Enter New PIN
    Wait Until Page Contains Element    ${LOGIN.CHOOSENEWPIN}
    ${PIN}    Set Variable If    '${PLATFORM}' == 'iOS'    ${LOGIN.EMAILIOS}    ${LOGIN.EMAIL}
    Wait For And Click Element    ${PIN}
    Input Text    ${PIN}    0000
    Wait For And Click Element    ${LOGIN.CHOOSENEWPINCONTINUE}

Confirm PIN
    Wait For And Click Element    ${LOGIN.CONFIRMNEWPIN}
    ${PIN}    Set Variable If    '${PLATFORM}' == 'iOS'    ${LOGIN.EMAILIOS}    ${LOGIN.EMAIL}
    Wait For And Click Element    ${PIN}
    Input Text    ${PIN}    0000
    Wait For And Click Element    ${LOGIN.CONFIRMPIN}

Home Page
    ${HOMEBUTTON}    Set Variable If    '${PLATFORM}' == 'iOS'    ${HOME.PROFILEIOS}    ${HOME.PROFILE}
    Wait Until Page Contains Element    ${HOMEBUTTON}    timeout=30

Reopen App With Biometric
    Background Application
    Activate Application    com.decode.rightvybe
    IF    ('${ENV}' == 'cloud' and '${PLATFORM}' == 'Android')
        Sleep    2
        Execute Script    ${BROWSERSTACK_BIOMETRIC_PASS}
    ELSE
        Enter PIN
    END
    ${HOMEBUTTON}    Set Variable If    '${PLATFORM}' == 'iOS'    ${HOME.PROFILEIOS}    ${HOME.PROFILE}
    Wait Until Page Contains Element    ${HOMEBUTTON}    timeout=30

Sign Out
    ${HOMEBUTTON}    Set Variable If    '${PLATFORM}' == 'iOS'    ${HOME.PROFILEIOS}    ${HOME.PROFILE}
    Wait Until Page Contains Element    ${HOMEBUTTON}    timeout=30
    Click Element    ${HOMEBUTTON}
    Wait Until Page Contains Element    ${PROFILE.DETAILS}
    IF    '${PLATFORM}' == 'Android'    Swipe By Percent    50    90    50    10    500
    Wait For And Click Element    ${PROFILE.SIGNOUT}
    Wait For And Click Element    ${PROFILE.SIGNOUTYES}
    IF    '${ENV}' == 'cloud'
        Execute Script    ${BROWSERSTACK_PASSED}
        ${BS_STATUS}    Set Variable    Passed
        Set Suite Variable    ${BS_STATUS}
    END

Register And Attempt Join Without Accepting Terms
    Wait For And Click Element    ${SIGNUP.REGISTER}
    Wait Until Page Contains Element    ${SIGNUP.JOIN}
    ${JOINSTATUS}    Get Element Attribute    ${SIGNUP.JOIN}    enabled
    Should Be Equal    ${JOINSTATUS}    false
    ${MAIL}    Set Variable If    '${PLATFORM}' == 'iOS'    ${LOGIN.EMAILIOS}    ${LOGIN.EMAIL}
    Wait For And Click Element    ${MAIL}
    Input Text    ${MAIL}    rv-at0002@rightvybe.testinator.com
    Wait For And Click Element    ${SIGNUP.JOINTITLE}
    ${JOINSTATUS}    Get Element Attribute    ${SIGNUP.JOIN}    enabled
    Should Be Equal    ${JOINSTATUS}    false

Register And Accept Terms And Join
    ${EMAIL}    Get New Unique Email
    ${MAIL}    Set Variable If    '${PLATFORM}' == 'iOS'    ${LOGIN.EMAILIOS}    ${LOGIN.EMAIL}
    Wait For And Click Element    ${MAIL}
    Clear Text    ${MAIL}
    Input Text    ${MAIL}    ${EMAIl}
    Wait For And Click Element    ${SIGNUP.JOINTITLE}
    ${CHECKBOX}    Set Variable If    '${PLATFORM}' == 'iOS'    ${SIGNUP.TERMSCHECKBOXIOS}    ${SIGNUP.TERMSCHECKBOX}
    Wait For And Click Element    ${CHECKBOX}
    ${JOINSTATUS}    Get Element Attribute    ${SIGNUP.JOIN}    enabled
    Should Be Equal    ${JOINSTATUS}    true
    Wait For And Click Element    ${SIGNUP.JOINTITLE}
    Wait For And Click Element    ${SIGNUP.JOIN}
    Wait Until Page Contains Element    ${LOGIN.CHECKEMAIL}    timeout=60

Success Page
    Wait Until Page Contains Element    ${SIGNUP.SUCCESS}    timeout=30
    Wait Until Page Contains Element    ${SIGNUP.SUCCESSMESSAGE}
    Wait For And Click Element    ${SIGNUP.CONTINUE}
    Wait Until Page Does Not Contain Element    ${SIGNUP.SUCCESS}

Enter Phone Number And Continue
    Wait Until Page Contains Element    ${SIGNUP.PHONENUMBER}    timeout=30
    ${CONTINUESTATUS}    Get Element Attribute    ${SIGNUP.CONTINUE}    enabled
    Should Be Equal    ${CONTINUESTATUS}    false
    ${NUMBER}    Set Variable If    '${PLATFORM}' == 'iOS'    ${LOGIN.EMAILIOS}    ${LOGIN.EMAIL}
    Wait For And Click Element    ${NUMBER}
    Input Text    ${NUMBER}    400029731
    Wait For And Click Element    ${SIGNUP.PHONENUMBER}
    ${CONTINUESTATUS}    Get Element Attribute    ${SIGNUP.CONTINUE}    enabled
    Should Be Equal    ${CONTINUESTATUS}    true
    Sleep     2
    Wait For And Click Element    ${SIGNUP.CONTINUE}

Get SMS PIN And Enter
    Wait Until Page Contains Element    ${SIGNUP.VERIRYPIN}    timeout=30
    Wait Until Page Contains Element    ${SIGNUP.RESENDCODE}
    ${VERIRFYSTATUS}    Get Element Attribute    ${SIGNUP.VERIRYDEVICE}    enabled
    Should Be Equal    ${VERIRFYSTATUS}    false
    Sleep    20
    ${SMS_PIN}    Get SMS Verification Code
    ${PIN}    Set Variable If    '${PLATFORM}' == 'iOS'    ${LOGIN.EMAILIOS}    ${LOGIN.EMAIL}
    Wait For And Click Element    ${PIN}
    Input Text    ${PIN}    ${SMS_PIN}
    Wait For And Click Element    ${SIGNUP.VERIRYPIN}
    ${VERIRFYSTATUS}    Get Element Attribute    ${SIGNUP.VERIRYDEVICE}    enabled
    Should Be Equal    ${VERIRFYSTATUS}    true
    Wait For And Click Element    ${SIGNUP.VERIRYDEVICE}
    ${STATUS}    Run Keyword And Return Status    Wait Until Page Contains Element    ${SIGNUP.ONBOARDINGNAME}
    IF    $STATUS == False
        Sleep    60
        Wait For And Click Element    ${PIN}
        IF    '${PLATFORM}' == 'Android'
            Press Keycode    67
            Press Keycode    67
            Press Keycode    67
            Press Keycode    67
        ELSE
            Click Element    accessibility_id=delete
            Click Element    accessibility_id=delete
            Click Element    accessibility_id=delete
            Click Element    accessibility_id=delete
        END
        ${SMS_PIN}    Get SMS Verification Code
        Input Text    ${PIN}    ${SMS_PIN}
        Wait For And Click Element    ${SIGNUP.VERIRYPIN}
        Wait Until Page Contains Element    ${SIGNUP.ONBOARDINGNAME}
    END

Enter First And Last Name
    Wait Until Page Contains Element    ${SIGNUP.ONBOARDINGNAME}    timeout=30
    Wait Until Page Contains Element    ${SIGNUP.SKIP}
    ${VERIRFYCONTINUE}    Get Element Attribute    ${SIGNUP.CONTINUE}    enabled
    Should Be Equal    ${VERIRFYCONTINUE}    false
    ${FIRSTNAME}    Set Variable If    '${PLATFORM}' == 'iOS'    ${SIGNUP.FIRSTNAMEIOS}    ${SIGNUP.FIRSTNAME}
    ${LASTNAME}     Set Variable If    '${PLATFORM}' == 'iOS'    ${SIGNUP.LASTNAMEIOS}     ${SIGNUP.LASTNAME}
    Wait For And Click Element    ${FIRSTNAME}
    Input Text    ${FIRSTNAME}    TestFirstName
    Wait For And Click Element    ${SIGNUP.ONBOARDINGNAME}
    Wait For And Click Element    ${LASTNAME}
    Input Text    ${LASTNAME}    TestLastName
    Wait For And Click Element    ${SIGNUP.ONBOARDINGNAME}
    ${VERIRFYCONTINUE}    Get Element Attribute    ${SIGNUP.CONTINUE}    enabled
    Should Be Equal    ${VERIRFYCONTINUE}    true
    Wait For And Click Element    ${SIGNUP.CONTINUE}

Onboarding Notification
    Wait Until Page Contains Element    ${SIGNUP.ONBOARDINGNOTIFICATION}    timeout=30
    Wait Until Page Contains Element    ${SIGNUP.SKIP}
    Wait For And Click Element    ${SIGNUP.ONBOARDINGNOTIFICATIONYES}

Referral Code Page
    Wait Until Page Contains Element    ${SIGNUP.ONBOARDINGREFERRALL}    timeout=30
    Wait Until Page Contains Element    ${SIGNUP.SKIP}
    ${VERIRFYCONTINUE}    Get Element Attribute    ${SIGNUP.CONTINUE}    enabled
    Should Be Equal    ${VERIRFYCONTINUE}    false
    ${NUMBER}    Set Variable If    '${PLATFORM}' == 'iOS'    ${LOGIN.EMAILIOS}    ${LOGIN.EMAIL}
    Wait For And Click Element    ${NUMBER}
    Input Text    ${NUMBER}    123456
    Wait For And Click Element    ${SIGNUP.ONBOARDINGREFERRALL}
    ${VERIRFYCONTINUE}    Get Element Attribute    ${SIGNUP.CONTINUE}    enabled
    Should Be Equal    ${VERIRFYCONTINUE}    true
    Wait For And Click Element    ${SIGNUP.ONBOARDINGREFERRALL}
    Wait For And Click Element    ${SIGNUP.SKIP}

Face ID Page
    Wait Until Page Contains Element    ${SIGNUP.ONBOARDINGFACEID}    timeout=30
    IF    ('${ENV}' == 'cloud' and '${PLATFORM}' == 'Android')
        Wait For And Click Element    ${SIGNUP.FACEID}
    ELSE
        Wait For And Click Element    ${SIGNUP.SKIP}
    END

Create Your PIN
    Wait Until Page Contains Element    ${SIGNUP.CREATEPIN}    timeout=30
    ${VERIRFYCONTINUE}    Get Element Attribute    ${SIGNUP.CONTINUE}    enabled
    Should Be Equal    ${VERIRFYCONTINUE}    false
    ${NUMBER}    Set Variable If    '${PLATFORM}' == 'iOS'    ${LOGIN.EMAILIOS}    ${LOGIN.EMAIL}
    Wait For And Click Element    ${NUMBER}
    Input Text    ${NUMBER}    0000
    Wait For And Click Element    ${SIGNUP.CREATEPIN}
    ${VERIRFYCONTINUE}    Get Element Attribute    ${SIGNUP.CONTINUE}    enabled
    Should Be Equal    ${VERIRFYCONTINUE}    true
    Wait For And Click Element    ${SIGNUP.CONTINUE}

Confirm Your PIN
    Wait Until Page Contains Element    ${SIGNUP.CONFIRMPIN}    timeout=30
    ${VERIRFYCONTINUE}    Get Element Attribute    ${SIGNUP.CREATEPINBUTTON}    enabled
    Should Be Equal    ${VERIRFYCONTINUE}    false
    ${NUMBER}    Set Variable If    '${PLATFORM}' == 'iOS'    ${LOGIN.EMAILIOS}    ${LOGIN.EMAIL}
    Wait For And Click Element    ${NUMBER}
    Input Text    ${NUMBER}    0000
    Wait For And Click Element    ${SIGNUP.CONFIRMPIN}
    ${VERIRFYCONTINUE}    Get Element Attribute    ${SIGNUP.CREATEPINBUTTON}    enabled
    Should Be Equal    ${VERIRFYCONTINUE}    true
    Wait For And Click Element    ${SIGNUP.CONFIRMPIN}
    Wait For And Click Element    ${SIGNUP.CREATEPINBUTTON}

Setup Action
    ${BS_STATUS}    Set Variable    In Progress
    Set Suite Variable    ${BS_STATUS}
    IF    ('${ENV}' == 'cloud' and '${PLATFORM}' == 'Android')
        Set Android Random Device
    ELSE IF    ('${ENV}' == 'cloud' and '${PLATFORM}' == 'iOS')
        Set IOS Random Device
    END
    ${ANDROID_APP_VERSION}    Get Android App Version
    Set Suite Variable    ${ANDROID_APP_VERSION}
    ${IOS_APP_VERSION}    Get iOS App Version
    Set Suite Variable    ${IOS_APP_VERSION}

Set IOS Random Device
    ${DEVICE_NAMES}    Get Dictionary Keys    ${IOSDEVICES}
    ${RANDOM_INDEX}    Evaluate    random.randint(0, len($DEVICE_NAMES)-1)    modules=random
    ${DEVICE}    Get From List    ${DEVICE_NAMES}    ${RANDOM_INDEX}
    ${OS_VERSION}    Get From Dictionary    ${IOS_DEVICES}    ${DEVICE}
    Set Global Variable    ${IOS_DEVICE}    ${DEVICE}
    Set Global Variable    ${IOS_OS_VERSION}    ${OS_VERSION}

Set Android Random Device
    ${DEVICE_NAMES}    Get Dictionary Keys    ${ANDROIDDEVICES}
    ${RANDOM_INDEX}    Evaluate    random.randint(0, len($DEVICE_NAMES)-1)    modules=random
    ${DEVICE}    Get From List    ${DEVICE_NAMES}    ${RANDOM_INDEX}
    ${OS_VERSION}    Get From Dictionary    ${ANDROID_DEVICES}    ${DEVICE}
    Set Global Variable    ${ANDROID_DEVICE}    ${DEVICE}
    Set Global Variable    ${ANDROID_OS_VERSION}    ${OS_VERSION}

Test Setup Action
    ${BS_STATUS}    Set Variable    In Progress
    Set Suite Variable    ${BS_STATUS}

Teardown Action
    IF    '${ENV}' == 'cloud'
        IF    $BS_STATUS != "Passed"
            Execute Script    ${BROWSERSTACK_FAILED}
        ELSE
            Execute Script    ${BROWSERSTACK_PASSED}
        END
    END
    Close All Applications