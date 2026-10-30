*** Settings ***
Library    Browser

*** Variables ***
${BASE_URL}        https://bstackdemo.com/
${BROWSER}         chromium
${HEADLESS}        ${FALSE}

*** Keywords ***
Open BStackDemo
    [Documentation]    Opens a Playwright browser session via Browser library and navigates to bstackdemo.
    New Browser    browser=${BROWSER}    headless=${HEADLESS}
    New Context    viewport={'width': 1280, 'height': 720}
    New Page       ${BASE_URL}
