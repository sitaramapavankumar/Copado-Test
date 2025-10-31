*** Settings ***
Resource                        ../common.robot
Test Setup                     Test startup
Test Teardown                  Close All Browsers

*** Test Cases ***
INT_PS-CSSUser_Approve_Returns-No Credit(T13)
    [Documentation]             Approving the complaint of Return - No Credits
    [Tags]                      PS-CSS User
    Profile User Common Steps                         ${TEST_NAME}
    Approval Approve
    CloseBrowser

INT_PS-CSSUser_Reject_Returns-No Credit(T13)
    [Documentation]             Rejecting the complaint of Return - No Credits
    [Tags]                      PS-CSS User
    Profile User Common Steps                         ${TEST_NAME}
    Approval Reject
    Logout the user