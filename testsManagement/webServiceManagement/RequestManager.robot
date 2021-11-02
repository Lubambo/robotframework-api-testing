*** Settings ***
Documentation  Doc.

Resource  ${EXECDIR}/resources/common/webService/RequestManager.robot
Resource  ${EXECDIR}/resources/common/ConsoleUtils.robot

Variables   ${EXECDIR}/resources/locators.py


*** Variables ***
${ALIAS}  ${project['api']['apiAlias']}


*** Keywords ***
Request
    [Documentation]  Envia uma requisição para o servidor de acordo com o método HTTP informado e os parâmetros passados.
    [Arguments]  ${requestMethod}  ${endpoint}  ${headers}=${EMPTY}  ${params}=${EMPTY}  ${body}=${EMPTY}  ${expected_status}=${-1}
    
    Print console INFO  URL em teste: ${project['api']['apiHost']}${endpoint}\n
    
    ${response}  Make Request  ${ALIAS}  ${requestMethod}  ${endpoint}  ${headers}  ${params}  ${body}  ${expected_status}

    [Return]  ${response}
