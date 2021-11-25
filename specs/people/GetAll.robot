*** Settings ***
Documentation  GetAll request all people registered in the Star Wars API.

Variables      ${EXECDIR}/resources/locators.py
Resource       ${EXECDIR}/testsManagement/webServiceManagement/endpoints/people/GET.robot
Resource       ${EXECDIR}/resources/common/ConsoleUtils.robot


*** Variables ***
${dataFile}  ${project['testData']['dataFolder']}/people/listAll.csv
&{sqlSetup}  dbName=${None}  file=${dataFile}


*** Keywords ***
HTTP Request
    # Get endpoint
    ${endpoint}  GET: All people
    
    # Make request
    ${response}  Request  ${HTTP_GET}  ${endpoint}

    [Return]  ${response}

Validate Response
    [Arguments]  ${response}

    ${schema}  Set Variable  ${EXECDIR}/data/json_schemas/people/listAll.json
    Conferir Response  ${response}  ${schema}  200

Validate Payload
    [Arguments]  ${response}  ${name}  ${height}
 
    ${results}   Get From Dictionary  ${response.json()}  results
    ${resultsStr}  Convert To String  ${results}

    ${pattern}  Set Variable  'name': '${name}', 'height': '${height}'

    Should Match Regexp  ${resultsStr}  ${pattern}

Validate Endpoint
    [Documentation]  condenses the request call and validations keywords.
    ...              It will be called in the test template keyword.
    [Arguments]  ${name}  ${height}

    # Request
    ${response}  HTTP Request
    
    # Validations
    Validate Response  ${response}
    Validate Payload   ${response}  ${name}  ${height}
