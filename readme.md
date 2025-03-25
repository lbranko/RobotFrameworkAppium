# Mobile Test Automation with Robot Framework

This repository contains automated tests for a mobile application using **Robot Framework** and **Appium**. The tests are configured to run both locally and on **BrowserStack**.

## 📌 Features
- Automated tests for **iOS** and **Android**
- Integration with **BrowserStack** for cloud execution
- GitHub Actions pipeline for scheduled test execution

## 🚀 Installation
### 1. Clone the repository
```bash
git clone https://github.com/lukacbrankodecode/RightVybe-Appium-Automation.git
cd RightVybe-automation
```

### 2. Create a virtual environment (optional but recommended)
```bash
python -m venv venv
source venv/bin/activate  # On Windows use `venv\Scripts\activate`
```

### 3. Install dependencies
```bash
pip install -r requirements.txt
```

### 4. Install and start Appium
If you don't have Appium installed, install it globally using npm:
```bash
npm install -g appium
```
Then, start Appium on the default port (4723):
```bash
appium
```

### 5. Configure security variables for BrowserStack
Create a `passwords.resource` file in the Resources folder and add:
```robot
*** Variables ***
${BROWSERSTACKUSERNAME}    your_username
${BROWSERSTACKACCESSKEY}    your_password
```

### 6. Set up the path for the .apk and .app files
Ensure that the paths to the application files are correctly set in your local environment. Update the relevant variables in your Robot Framework test files:
```robot
*** Variables ***
${APK_APP_PATH_LOCAL}    /path/to/your/app.apk
${APP_APP_PATH_LOCAL}        /path/to/your/app.app
```
Replace `/path/to/your/app.apk` and `/path/to/your/app.app` with the actual paths to your application files on your machine.

## 🏃 Running Tests
### Run tests locally
```bash
robot -d Results -v platform:iOS -v env:local Tests/"01-Login and reset PIN.robot"
```
```bash
robot -d Results -v platform:Android -v env:local Tests/"02-Sign-up.robot"
```

### Run tests on BrowserStack
```bash
robot -d Results -v platform:iOS -v env:cloud Tests/"01-Login and reset PIN.robot"
```
```bash
robot -d Results -v platform:Android -v env:cloud Tests/"02-Sign-up.robot"
```

## 🔄 CI/CD with GitHub Actions
- Tests run daily at **04:00 UTC** via **GitHub Actions**.
- Test results are uploaded as artifacts in the **Actions** tab.

## 📂 Project Structure
```
├── .github/workflows/    # GitHub Actions workflows
├── Resources/            # Test keywords and resources
├── Tests/                # Test cases
├── Results/              # Test execution results
├── Scripts/              # Utility scripts
├── .gitignore            # Ignored files and folders
├── requirements.txt      # Python dependencies
└── README.md             # Documentation
```

