*** Settings ***
Documentation        This is a resource file, that can contain variables.
...                  Keywords defined here can be used where this objects.resource in loaded.


*** Variables ***
${LOGIN.LOGIN}    accessibility_id=Log in
${LOGIN.WELCOMEBACK}    accessibility_id=Welcome back!
${LOGIN.EMAIL}    xpath=//android.widget.EditText
${LOGIN.EMAILIOS}    xpath=//XCUIElementTypeTextField
${LOGIN.SENDLINK}    accessibility_id=Send the magic link
${LOGIN.CHECKEMAIL}    accessibility_id=Resend magic link
${LOGIN.UNLOCK}    accessibility_id=Unlock
${LOGIN.RESETPINEMAIL}    accessibility_id=Reset PIN via email
${LOGIN.RESETPINPHONE}    accessibility_id=Reset PIN via phone
${LOGIN.SENDAGAIN}    accessibility_id=Send again
${LOGIN.ENTERPIN}    accessibility_id=Enter your PIN
${LOGIN.EMAILSENT}    accessibility_id=Email sent!
${LOGIN.CHOOSENEWPIN}    accessibility_id=Choose your NEW PIN
${LOGIN.CHOOSENEWPINCONTINUE}    accessibility_id=Continue
${LOGIN.CONFIRMNEWPIN}    accessibility_id=Confirm your NEW PIN
${LOGIN.CONFIRMPIN}    accessibility_id=Confirm PIN
${HOME}    xpath=//*[contains(@content-desc, "Home")]
${HOMEIOS}    xpath=//*[contains(@accessibilityLabel, "Home")]
${PROFILE.SIGNOUT}    accessibility_id=Log out
${PROFILE.SIGNOUTYES}    accessibility_id=Yes
${SIGNUP.REGISTER}    accessibility_id=Register
${SIGNUP.JOINTITLE}    accessibility_id=Join rightvybe
${SIGNUP.JOIN}    accessibility_id=Join the Vybe tribe
${SIGNUP.TERMSCHECKBOX}    xpath=//android.widget.CheckBox
${SIGNUP.TERMSCHECKBOXIOS}    xpath=//XCUIElementTypeSwitch[@value="0"]
${SIGNUP.SUCCESS}    accessibility_id=Success!
${SIGNUP.SUCCESSMESSAGE}    accessibility_id=Your email has been verified
${SIGNUP.CONTINUE}    accessibility_id=Continue
${SIGNUP.PHONENUMBER}    accessibility_id=What’s your phone number?
${SIGNUP.VERIRYPIN}    accessibility_id=Verify your device
${SIGNUP.VERIRYDEVICE}    accessibility_id=Verify my device
${SIGNUP.RESENDCODE}    accessibility_id=Resend code
${SIGNUP.ONBOARDINGNAME}    accessibility_id=Let’s get to know each other
${SIGNUP.SKIP}    accessibility_id=Skip for now
${SIGNUP.FIRSTNAME}    xpath=(//android.widget.EditText)[1]
${SIGNUP.FIRSTNAMEIOS}    xpath=(//XCUIElementTypeTextField)[1]
${SIGNUP.LASTNAME}    xpath=(//android.widget.EditText)[2]
${SIGNUP.LASTNAMEIOS}    xpath=(//XCUIElementTypeTextField)[2]
${SIGNUP.ONBOARDINGNOTIFICATION}    accessibility_id=We’d like to send you notifications
${SIGNUP.ONBOARDINGNOTIFICATIONYES}    accessibility_id=Yes, send me updates!
${SIGNUP.ONBOARDINGREFERRALL}    accessibility_id=Did someone say bonus points?!
${SIGNUP.ONBOARDINGFACEID}    accessibility_id=Log in faster with Face ID
${SIGNUP.FACEID}    accessibility_id=Yes, make logging in faster
${SIGNUP.CREATEPIN}    accessibility_id=Create your PIN
${SIGNUP.CONFIRMPIN}    accessibility_id=Confirm your PIN
${SIGNUP.CREATEPINBUTTON}    accessibility_id=Create my PIN
${HOME.PROFILE}    xpath=(//android.widget.ImageView)[2]
${HOME.PROFILEIOS}    xpath=(//XCUIElementTypeButton)[1]
${PROFILE.DETAILS}    accessibility_id=Your Details
${PROFILE.PRIVACY}    accessibility_id=Privacy Policy