*** Settings ***
Documentation  Recurso utilizado para gerenciar operações com JSON.
Library  OperatingSystem
Library  ${EXECDIR}/resources/libs/Json/JsonUtils.py

*** Keywords ***
Read JSON file
    [Arguments]  ${filePath}
    
    ${file}  GET FILE  ${filePath}
    ${json}  Evaluate  json.loads('''${file}''')  json

    [Return]  ${json}

Validate JSON
    [Documentation]  Valida se o json passado no parâmetro possui o
    ...              mesmo esquema esperado.
    [Arguments]  ${json}  ${schema}

    ${isValid}  Validate JSON Schema  json=${json}  schema=${schema}
    Should Be True  ${isValid}