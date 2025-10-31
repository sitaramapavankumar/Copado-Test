*** Settings ***
Resource                        ../common.robot
Test Setup                     Test startup
Test Teardown                  Close All Browsers

*** Test Cases ***
INT_PS-CSSUser_Approve_Replacement-FOC(T10)
    [Documentation]             Approving the complaint of Replacement FOC
    [Tags]                      PS-CSS User
    Profile User Common Steps                         ${TEST_NAME}
    Approval Approve
    CloseBrowser

INT_PS-CSSUser_Reject_Replacement-FOC(T10)
    [Documentation]             Rejecting the complaint of Replacement FOC
    [Tags]                      PS-CSS User
    Profile User Common Steps                         ${TEST_NAME}
    Approval Reject
    Logout the user