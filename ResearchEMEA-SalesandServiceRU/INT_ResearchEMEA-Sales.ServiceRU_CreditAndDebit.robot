*** Settings ***
Resource                        ../test/common.robot
Suite Setup                     Test startup
Suite Teardown                  Close All Browsers

*** Test Cases ***
INT_Research EMEA - Sales.Service RU_Approve_Credit and Debit(T16)
    [Documentation]             Approving the complaint of Credit and Debit
    [Tags]                      Research EMEA - Sales.Service RU
    Profile User Common Steps                               ${TEST_NAME}
    Approval Approve
    CloseBrowser