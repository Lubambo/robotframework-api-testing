*** Settings ***
Documentation  Roteador de criação de parâmetros de conexão com os bancos de dados.

*** Keywords ***
Get DB Connection Params
    [Arguments]  ${dbName}  &{dbsInfos}

    ${params}  Set Variable  &{EMPTY}

    FOR  ${key}  IN  @{dbsInfos.keys()}
        ${sameName}  Set Variable  '${dbName}' == '${dbsInfos['${key}']['dbName']}'
        
        IF  ${sameName}
            ${params}  Set Variable  ${dbsInfos['${key}']}
        END

        Exit For Loop If  ${sameName}
    END

    [Return]  ${params}

