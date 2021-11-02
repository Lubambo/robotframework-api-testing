*** Settings ***
Documentation  Recurso para padronizar a criação de parâmetros de conexão com o banco de dados.
Library  Collections

*** Keywords ***
Create Base Connection
    [Arguments]  ${apiModule}  ${service}  ${host}  ${port}
    ${baseConn}  Create Dictionary  apiModule=${apiModule}  service=${service}  host=${host}  port=${port}

    [Return]  ${baseConn}

Set Connection Params
    [Arguments]  ${baseConn}  ${username}  ${password}  ${dbName}

    Set To Dictionary  ${baseConn}  username=${username}  password=${password}  dbName=${dbName}
    [Return]  ${baseConn}
