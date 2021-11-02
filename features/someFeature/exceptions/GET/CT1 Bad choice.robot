*** Settings ***
Documentation  CT1 Bad choice definition.

Default Tags   all  exception  some-feature  some-feature-exception  some-feature-exception-get  some-feature-exception-get-ct1

Resource       ${EXECDIR}/specs/common/ExceptionsTestsConfig.robot
Resource       ${EXECDIR}/testsManagement/webServiceManagement/endpoints/someFeature/GET.robot

Test Setup      Open Session
Test Teardown   Close Session

Test Template   Test Case Template

*** Variables ***
${feature}   someFeature
${testData}  by_id.csv

*** Test Cases ***
Test Case Name (${label})  ${params}  ${expectedStatusCode}

*** Keywords ***
Test Case Template
    [Arguments]  ${params}  ${expectedStatusCode}

    # Endpoint
    ${endpoint}  GET: Feature by id  ${params}

    # Validações
    Exception Test  ${endpoint}  ${expectedStatusCode}
