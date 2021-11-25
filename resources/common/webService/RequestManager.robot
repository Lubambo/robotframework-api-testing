*** Settings ***
Documentation  Interface para gerenciamento de requisições HTTP.

Library   RequestsLibrary
Library   Collections
Library   String


*** Variables ***
### Métodos Http
${HTTP_GET}     "GET"
${HTTP_POST}    "POST"
${HTTP_PUT}     "PUT"
${HTTP_DEL}     "DELETE"


*** Keywords ***
Make Request
    [Documentation]  Envia uma requisição para o servidor de acordo com o método HTTP informado e os parâmetros passados.
    [Arguments]  ${alias}  ${requestMethod}  ${endpoint}  ${headers}=${EMPTY}  ${params}=${EMPTY}  ${body}=${EMPTY}  ${expected_status}=${-1}

    # Solução para problemas de permissão da requisição no servidor
    IF  '${headers}' == '${EMPTY}'
        ${headers}  Create Dictionary  User-Agent=Chrome/56.0.2924.76
    END

    ${response}  SET VARIABLE  ${EMPTY}

    ${expectedStatusCode}  Set Variable  ${EMPTY}

    # GET
    IF  ${requestMethod} == ${HTTP_GET}
        # Verifica o status code esperado
        IF  ${expected_status} != ${-1}
            ${expectedStatusCode}  Set Variable  ${expected_status}
        ELSE
            ${expectedStatusCode}  Set Variable  200
        END

        ${response}  GET ON SESSION  alias=${alias}  url=${endpoint}  headers=${headers}  params=${params}  expected_status=${expectedStatusCode}
        
    # POST
    ELSE IF  ${requestMethod} == ${HTTP_POST}

        # Verifica o status code esperado
        IF  ${expected_status} != ${-1}
            ${expectedStatusCode}  Set Variable  ${expected_status}
        ELSE
            ${expectedStatusCode}  Set Variable  201
        END
        
        ${response}  POST ON SESSION  alias=${alias}  url=${endpoint}  headers=&{headers}  params=&{params}  data=&{body}  expected_status=${expectedStatusCode}

    END

    #LOG  ${response}
    [Return]  ${response}

Conferir Status Code
    [Documentation]  Compara o "Status Code" recebido na response com um valor esperado.
    [Arguments]  ${response}  ${expectedStatusCode}

    SHOULD BE EQUAL AS STRINGS  ${response.status_code}  ${expectedStatusCode}

Conferir Reason
    [Documentation]  Compara o "Reason" recebido na response com um valor esperado.
    [Arguments]  ${response}  ${expectedReason}

    ${result}  CONVERT TO UPPER CASE  ${response.reason}
    ${expected}  CONVERT TO UPPER CASE  ${expectedReason}
    SHOULD BE EQUAL AS STRINGS  ${result}  ${expected}
    
Conferir Header
    [Documentation]  Compara um item do "Header" recebido na response com um valor esperado.
    [Arguments]  ${response}  ${key}  ${expectedValue}

    DICTIONARY SHOULD CONTAIN ITEM  ${response.headers}  ${key}  ${expectedValue}

Conferir Response
    [Documentation]  Condensa verificações que se repetem igualmente em vários testes.
    [Arguments]  ${response}  ${expectedSchema}  ${expectedStatusCode}=200

    Conferir Status Code  ${response}  ${expectedStatusCode}
    Conferir Header  ${response}  Content-Type  application/json
    ${schema}  Read JSON file  ${expectedSchema}
    Validate JSON  ${response.json()}  ${schema}

Conferir Body 
    [Documentation]  Compara um item do "Body" recebido na response com um valor esperado.
    [Arguments]  ${content}  ${key}  ${expectedValue}

    DICTIONARY SHOULD CONTAIN ITEM  ${content}  ${key}  ${expectedValue}

Conferir request problemático
    [Documentation]  Verifica se o request realizado é de fato um request problemático.
    [Arguments]  ${response}  ${statusCode}

    Should Be True  "${statusCode}" in """${response}"""
