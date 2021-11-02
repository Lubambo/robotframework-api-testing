*** Settings ***
Documentation  Condenses libraries, variables and keywords used in more than one testes de exceção.
...            The variable ${testData}, used as part of the test file path on the DataDriver Library
...            call, has its value passed on the feature file, this way the path can easely changed.

Resource       ${testsManager}/webServiceManagement/SessionManager.robot
Resource       ${testsManager}/webServiceManagement/RequestManager.robot

Library        DataDriver  ${EXECDIR}/data/test_data/${feature}/exceptions/${testData}  encoding=utf_8

*** Variables ***
# Test variables.
${void}            ${EMPTY}
${invalidLetters}  xyz
${invalidNumbers}  99999999
${nonexistent}     nonexistent

*** Keywords ***
Exception Test
    [Arguments]  ${endpoint}  ${expectedStatusCode}

    # Request.
    ${response}  Make Request  ${HTTP_GET}  ${endpoint}  expected_status=${expectedStatusCode}

    # Validations.
    IF  ${response.status_code} == 200
        Length Should Be  ${response.json()}  0
    END