*** Settings ***
Documentation  SpecName definition.

Variables      ${EXECDIR}/resources/locators.py
Resource       ${EXECDIR}/specs/someFeature_spec/Common.robot
Resource       ${EXECDIR}/testsManagement/webServiceManagement/endpoints/someFeature/GET.robot
Resource       ${EXECDIR}/resources/common/ConsoleUtils.robot

*** Variables ***
# Database Query informations:
# In order to get data from database, there are some mandatory values that you must inform.
# They are: ${sqlTable}, @{sqlColumns}, &{sqlSetup}.
# Inside &{sqlSetup}, the standard set of key-value pair must be preserved, although "dbName"
# is not mandatory if your project has a standard database connection setted in
# testsManagement/dataManagement/DataManager.robot
${sqlTable}    Table_Name
@{sqlColumns}  Col_One  Col_Two  Col_Three
@{filters}     WHERE Col_N = 'ON'
&{sqlSetup}    template=${sqlScript}  table=${sqlTable}  columns=${sqlColumns}
...            amount=${sqlAmount}  filters=${filters}  #dbName=${project['database']['dbOneName']}
#...            dbName=${None}  file=${filePath}


*** Keywords ***
HTTP Request
    # Get endpoint
    ${endpoint}  GET: Features
    
    # Make request
    ${response}  Request  ${HTTP_GET}  ${endpoint}

    [Return]  ${response}

Validate Response
    [Arguments]  ${response}

    # Make your response validation

Validate Payload
    [Arguments]  ${response}  ${arg1}  ${arg2}  ${arg3}

    # Make your payload validation

Validate Endpoint
    [Documentation]  condenses the request call and validations keywords.
    ...              It will be called in the test template keyword.
    [Arguments]  ${arg1}  ${arg2}  ${arg3}

    # Request
    ${response}  HTTP Request
    
    # Validations
    Validate Response  ${response}
    Validate Payload   ${response}  ${arg1}  ${arg2}  ${arg3}
