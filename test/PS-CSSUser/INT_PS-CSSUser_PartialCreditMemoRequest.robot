*** Settings ***
Resource                        ../common.robot
Test Setup                     Test startup
Test Teardown                  Close All Browsers

*** Test Cases ***
INT_PS-CSSUser_Approve_Partial Credit Memo Request(T15)
    [Documentation]             Approving the complaint of Partial Credit Memo Request
    [Tags]                      PS-CSS User
    Profile User Common Steps                         ${TEST_NAME}
    Approval Approve
    CloseBrowser

INT_PS-CSSUser_Reject_Partial Credit Memo Request(T15)
    [Documentation]             Rejecting the complaint of Partial Credit Memo Request
    [Tags]                      PS-CSS User
    Profile User Common Steps                         ${TEST_NAME}
    Approval Reject
    Logout the user