*** Settings ***
Resource                        ../test/common.robot
Test Setup                     Test startup
Test Teardown                  Close All Browsers

*** Test Cases ***
INT_Research EMEA - Sales.Service RU_Approve_Credit Memo Request(T18)
    [Documentation]             Approving the complaint of Credit Memo Request
    [Tags]                      Research EMEA - Sales.Service RU
    Profile User Common Steps                               ${TEST_NAME}
    Approval Approve
    CloseBrowser
