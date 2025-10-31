*** Settings ***
Resource                        ../common.robot
Test Setup                     Test startup
Test Teardown                  Close All Browsers

*** Test Cases ***
INT_PS-CSSUser_Approve_Partial Debit Memo Request(T17)
    [Documentation]             Approving the complaint of Partial Debit Memo Request
    [Tags]                      PS-CSS User
    Profile User Common Steps                         ${TEST_NAME}
    Approval Approve
    CloseBrowser

INT_PS-CSSUser_Reject_Partial Debit Memo Request(T17)
    [Documentation]             Rejecting the complaint of Partial Debit Memo Request
    [Tags]                      PS-CSS User
    Profile User Common Steps                         ${TEST_NAME}
    Approval Reject
    Logout the user