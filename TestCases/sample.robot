*** Settings ***
Library  SeleniumLibrary
Library  Collections
Resource  ../Resources/keywords.robot
#Test Setup  Open Maintenance Tab  ${url}  ${browser}  ${userId}  ${password}
#Test Teardown  Close Window and Log

*** Variables ***
${url}  https://trunk.fleetup.net/
${browser}  Chrome
${user_id}  CTestAdmin
${password}  qweasd
${maintenance_tab}  xPath://a[@id='menu_256']
${alert_tab}  xPath://a[@id='menu_2']


*** Test Cases ***
Availability of Maintenance Tab
    Open Tab  ${url}  ${browser}  ${user_id}  ${password}  ${maintenance_tab}
    Sleep  10
    Element Should Be Visible  xpath://table[@class='hover table table-striped table-bordered']


Check All Vehicles In Account Are Displayed
    [Documentation]  Get vehicles from eMaintenance and from Devcie Setting tab and compare
    # Vehicles from Maintenance tab
    ${count_row} =  Get Element Count  xpath://*[@class = 'ng-scope']//tbody//td[2]
    @{vehicles} =  create list
    :FOR  ${i}  IN RANGE  3  ${count_row}+3
    \  ${vehicle} =  Get Table Cell  xpath://table[@class='hover table table-striped table-bordered']  ${i}  2
    \  Append To List  ${vehicles}  ${vehicle}
    Sort List  ${vehicles}
    Log List  ${vehicles}

    # Move to Vehicle Setting page
    Click Element  xpath://div[@class='btn-group']//div[2]//button[1]
    Page Should Contain  Logout
    Click Element  xpath://a[contains(text(),'Setting')]
    Click Element After Opening New Page  xpath://li[@id='settingNav_01']//a
    Page Should Contain Element  xpath://table[@id='deviceVehicleSetting']//tbody
    Sleep  10  # Padding for loading time
    ${count_row_2} =  Get Element Count  xpath://table[@id='deviceVehicleSetting']//tbody//tr
    @{account_vehicles} =  create list
    :FOR  ${j}  IN RANGE  2  ${count_row_2}+2
    \  ${account_vehicle} =  GET TABLE Cell  xpath://table[@id='deviceVehicleSetting']  ${j}  ${2}
    \  Append To List  ${account_vehicles}  ${account_vehicle}
    Sort List  ${account_vehicles}
    Log List  ${account_vehicles}
    Lists Should Be Equal  ${vehicles}  ${account_vehicles}