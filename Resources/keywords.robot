*** Settings ***
Library  SeleniumLibrary

*** Variables ***


*** Keywords ***
Open and Maximize Window
    [Arguments]  ${url}  ${browser}
    Open Browser  ${url}  ${browser}
    Maximize Browser Window

Close Window and Log
    Close All Borwsers
    Log  Done Testing

Click Element After Opening New Page
    [Documentation]  On Fleetup Website, we block the button to be clicked before loading the whole page fully. So add two buffers to block NoSuchELement error and unclickable error
    [Arguments]  ${element_to_load}
    # Buffer1
    Sleep  15
    # Buffer2
    Wait Until Element Is Visible  ${element_to_load}
    Click Element  ${element_to_load}

Open Tab
    [Arguments]  ${url}  ${browser}  ${user_id}  ${password}  ${locator}
    Open and Maximize Window  ${url}  ${browser}
    Input Text  name:userId  ${user_id}
    Input Password  name:password  ${password}
    Click Element  name:4
    Click Element After Opening New Page  ${locator}
