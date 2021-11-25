*** Settings ***
Documentation  Validate the response expected from all registered in the Star Wars API.

Default Tags  all  people  people-get

Resource  ${EXECDIR}/specs/common/GeneralConfig.robot
Resource  ${EXECDIR}/specs/people/GetAll.robot

Suite Teardown  Remove Test Data File 

Test Setup      Open Session
Test Teardown   Close Session

Test Template   Test Case Template

*** Test Cases ***
Get all people: validating [${name}]

*** Keywords ***
Test Case Template
    [Documentation]  Calls the spec template keyword.
    [Arguments]  ${name}  ${height}
    
    Validate Endpoint  ${name}  ${height}