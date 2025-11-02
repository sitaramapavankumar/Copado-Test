*** Settings ***
Library                         DateTime
Library                         OperatingSystem
Library                         QWeb            #screenshot_on_fail=False
Library                         String
Library                         Collections
Library                         XML
#Variables                         ${CURDIR}/../browser1.py
Variables                       ${CURDIR}/../CommonTestData.py

*** Variables ***
${FileName}                     ${CURDIR}/TestData/TestData.csv
@{TestdataList}
${TestCaseName}
${Url}
${Username}
${Password}
${Profileuser}
${ApprovalStatus}
${Contact}
${salesorderID}
${Value}
${user}
${TEST_NAME}
${CreditAndebitString}          Credit and Debit
${CSSUser}                      CSSUser
${Export}                       Export
${Commercial}                   Commercial
${SalesandService}              Service
${Sales}                        Sales
${SuperUser}                    Super User
${Customer}                     Customer

*** Keywords ***
Fetching TestData
    [Arguments]                 ${TEST_NAME}
    Log                         ${TEST_NAME}
    ${File_Content}             Get File                    ${FileName}
    ${File_String}              Convert To String           ${File_Content}
    @{File_Lines}               Split String                ${File_String}              separator=\n
    FOR                         ${Lines}                    IN                          @{File_Lines}
        @{ROWS}                 Split String                ${Lines}                    separator=;
        ${TCName}               Get From List               ${ROWS}                     0
        IF                      '${TCName}' == '${TEST_NAME}'
            ${Profileuser}      Get From List               ${ROWS}                     1
            ${Contact}          Get From List               ${ROWS}                     2
            ${salesorderID}     Get From List               ${ROWS}                     3
            ${ApprovalStatus}                               Get From List               ${ROWS}                     4
            ${Value}            Get From List               ${ROWS}                     5
            ${user}             Get From List               ${ROWS}                     6
            Append To List      ${TestdataList}             ${Profileuser}
            Append To List      ${TestdataList}             ${Contact}
            Append To List      ${TestdataList}             ${salesorderID}
            Append To List      ${TestdataList}             ${ApprovalStatus}
            Append To List      ${TestdataList}             ${Value}
            Append To List      ${TestdataList}             ${user}
        END
    END
    RETURN                    ${TestdataList}

Test startup
    OpenBrowser                about:blank                 chrome    headless=True     #options=--version 110    #Chrome=110    browser_alias= chrome    #headless=True  width=1920    height=1200   #options=--disable-extensions          headless=True  width=1920    height=1200
    SetConfig                   LineBreak                   ${EMPTY}                    #\ue000
    SetConfig                   DefaultTimeout              60s
    Set Variables

Set Variables
    [Documentation]             Set dynamic suite variables
    ${current_date}=            Get Current Date            exclude_millis=True
    Set Suite Variable          ${current_date}

LoginToSalesforce
    [Documentation]             Login to Salesforce instance
    GoTo                        ${TestData_Uat.Url}
    TypeText                    Username                    ${TestData_Uat.Username}                 delay=1
    TypeText                    Password                    ${TestData_Uat.Password}
    ClickText                   Log In to Sandbox
    Sleep                       7s
    #ClickText                   App Launcher
    #ClickText                   Search apps and items...
    #TypeText                    Search apps and items...    Process Solutions
    #ClickText                   Process Solutions           2
    #Sleep                       4s

Log into Profile
    [Arguments]                 ${Profileuser}
    Sleep                       3s
    ClickElement                //lightning-icon[contains(@class,'slds-icon-utility-setup slds-button__icon slds-global-header__icon forceIcon slds-icon_container')]       anchor=Notifications
    ClickText                   Opens in a new tab
    SwitchWindow                NEW
    SwitchWindow                2
    ClickText                   User
    TypeText                    Search Setup                ${Profileuser}
    Sleep                       5s
    ClickText                   in Setup
    Sleep                       3s
    ClickText                   Top Results
    Sleep                       5s
    Click Text                  //span[text()\='Users']           anchor=Top Results
    Sleep                       4s
    UseTable                    //table[@class\='slds-table slds-table_cell-buffer slds-table_bordered uiVirtualDataGrid--default uiVirtualDataGrid'][1]
    Sleep                       3s
    ClickText                   ${Profileuser}
    Sleep                       5s
    ClickText                   Login                       #anchor=Reset Password
    Sleep                       8s

Launching Service Console
    ClickText                   App Launcher
    ClickText                   Search apps and items...
    TypeText                    Search apps and items...    Service Console
    ClickText                   //b[text()\='Service Console']
    Sleep                       4s
    Click Element               (//span[text()\='Cases'])[1]
    Sleep                       2s
    ClickText                   Show more actions           delay=2
    Sleep                       4s
    Clicktext                   Comp. with Reference        timeout=10s
    Sleep                       7s
Reference Document Type
    [Arguments]                 ${salesorderID}
    ClickElement                //span[contains(text(),'Sales Order')]
    #ClickText                  Sales Order
    Sleep                       3s
    TypeText                    (//input[@type\='text'])[1]      3005417801                  anchor=Add
    #TypeText                   Add                         3000009077
    #Searching the sales orderID
    Click Element               //button[text()\='Search']
    Sleep                       10s
    ClickElement                //span[text()\='Select Item 1']         timeout=60s
    ClickText                   Ok
    Clicktext                   Create Complaint
    VerifyText                  SAP Followup Documents      timeout=60s
    Sleep                       4s
Create Complaint
    [Arguments]                 ${Contact}
    log to console              Before Entering the Subject
    TypeText                    Subject                     price
    log to console              After Entering the Subject
    Sleep                       4s
    ClickText                   Order Reason
    ScrollTo                    103_Quantity Discrepancy
    ClickText                   103_Quantity Discrepancy
    Sleep                       4s
    #Filling the complaint details form-Subject,Order Reason,Main Complaint area,Contact Name,TW Problem Category and code,Description
    TypeText                    (//input[@placeholder\="Search Contacts..."])[2]               ${Contact}                  timeout=10s
    ClickText                   Show more results
    Sleep                       3s
    Click Element               //span[@class\='slds-radio_faux']
    Click Element               //button[text()\='Select']
    sleep                       2
    ClickElement                //*[contains(text(),"TW Problem Category")]//following-sibling::div[@class\='slds-form-element__control']//button[@class\='slds-combobox__input slds-input_faux fix-slds-input_faux slds-combobox__input-value']
    sleep                       3
    ClickText                   PRICE
    ClickText                   *Main Complaint Area / Defect Location
    ScrollTo                    CARR - Carrier
    ClickText                   CARR - Carrier
    ClickElement                //*[contains(text(),"TW Problem Code")]//following-sibling::div[@class\='slds-form-element__control']//button[@class\='slds-combobox__input slds-input_faux fix-slds-input_faux slds-combobox__input-value']
    ClickText                   Price Discrepancy
    TypeText                    *Description                 price
    ClickText                   Save                        partial_match=false
    Sleep                       4s

Create Request
    [Arguments]                 ${Value}
    ClickText                   //a[text()\='Action']
    VerifyText                  Action Type
    DropDown                    --None--                    ${Value}                    anchor=Action Type          timeout=25s
    TypeText                    (//input[@class\='slds-input'])[3]                   4567
    ClickText                   Extend Item
    Sleep                       3s
    SwipeUp
    DropDown                    --None--                    ${Value}                    index=1
    ClickText                   Approval Request            timeout=60s

Create a request for Credit and Debit
    ClickUntil                  Extend Item                //a[text()\='Action']                                     timeout=60s
    DropDown                    --None--                    Credit Memo Request         anchor=Action Type          timeout=25s
    TypeText                    (//input[@class\='slds-input'])[3]                    4567
    ClickText                   Extend Item
    Uncheck Request Items
    DropDown                    --None--                    Debit Memo Request          anchor=Action Type          timeout=25s
    ClickText                   Extend Item
    Sleep                       3s
    SwipeUp
    DropDown                    --None--                    Credit and Debit            index=1        timeout=25s
    ClickText                   Approval Request            timeout=60s

Uncheck Request Items
    #unchecking the checkbox for Request item
    UseTable                    Item NO
    HoverElement                xpath\=//*[@id\='itemsTable']//tr[3]/td/label/span[@class\='slds-checkbox--faux']
    ClickElement                xpath\=//*[@id\='itemsTable']//tr[3]/td/label/span[@class\='slds-checkbox--faux']

Submit Approval Request
    [Arguments]                 ${user}
    VerifyText                  First Level Approver        timeout=40s
    TypeText                    First Level Approver        ${user}                     timeout=60s
    ClickText                   First Level Approver
    ClickUntil                  Approval Request Submitted                              Submit for Approval         timeout=100s

Approval Approve
    #Approve the Complaint
    #ClickText                  Approve                     index=1                     anchor=Actual Approver
    ClickText                   //div[@title\='Approve']
    Sleep                       6s
    TypeText                    Comments                    approved
    Click Element               //span[text()\='Approve']
    Sleep                       3s
    VerifyText                  Approved

Approval Reject
    #Rejecting the complaint
    ClickText                   Reject                      anchor=Actual Approver
    Sleep                       6s
    TypeText                    Comments                    poor quality
    Click Element               //span[text()\='Reject']
    Sleep                       3s
    VerifyText                  Rejected

Logout the user
    ClickText                   View profile
    ClickText                   Log Out

Profile User Common Steps
    [Arguments]                 ${TEST_NAME}
    ${OutputValue}              Fetching TestData           ${TEST_NAME}
    ${Profileuser}              Set Variable                ${OutputValue}[0]
    ${Contact}                  Set Variable                ${OutputValue}[1]
    ${salesorderID}             Set Variable                ${OutputValue}[2]
    ${Value}                    Set Variable                ${OutputValue}[4]
    ${user}                     Set Variable                ${OutputValue}[5]
    LoginToSalesforce
    IF                          '${CSSUser}' in '${TEST_NAME}'
        Log into Profile        ${Profileuser}

    ELSE IF                     '${Export}' in '${TEST_NAME}'
        Log into Profile        ${Profileuser}

    ELSE IF                     '${Commercial}' in '${TEST_NAME}'
        Log into Profile        ${Profileuser}

    ELSE IF                     '${Customer}' in '${TEST_NAME}'
        Log into Profile        ${Profileuser}

    ELSE IF                     '${SuperUser}' in '${TEST_NAME}'
        Log into Profile        ${Profileuser}

    ELSE IF                     '${SalesandService}' in '${TEST_NAME}'
        Log into Profile        ${Profileuser}

    ELSE IF                     '${Sales}' in '${TEST_NAME}'
        Log into Profile        ${Profileuser}
    END
    Launching Service Console
    Reference Document Type     ${salesorderID}
    Create Complaint            ${Contact}
    IF                          '${CreditAndebitString}' in '${TEST_NAME}'
        Create a request for Credit and Debit
    ELSE
        Create Request          ${Value}
    END
    Submit Approval Request     ${user}
