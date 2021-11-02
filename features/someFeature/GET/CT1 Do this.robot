*** Settings ***
Documentation  CT1 Do this definition.

Default Tags  all  some-feature  some-feature-get  some-feature-get-ct1

Resource  ${EXECDIR}/specs/common/GeneralConfig.robot
Resource  ${EXECDIR}/specs/someFeature_spec/SpecName.robot

Suite Teardown  Remove Test Data File 

Test Setup      Open Session
Test Teardown   Close Session

Test Template   Test Case Template

*** Test Cases ***
Test Case Name (verificando id: ${arg1})

*** Keywords ***
Test Case Template
    [Documentation]  Calls the spec template keyword.
    [Arguments]  ${arg1}  ${arg2}  ${arg3}
    
    Validate Endpoint  ${arg1}  ${arg2}  ${arg3}