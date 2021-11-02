*** Settings ***
Documentation  Gerenciamento de interação com o banco de dados.
Resource   ${EXECDIR}/resources/common/ConsoleUtils.robot

Library  DatabaseLibrary
Library  OperatingSystem
Library  String

*** Keywords ***
Connect Database
    [Arguments]  ${connParams}

    CONNECT TO DATABASE USING CUSTOM PARAMS    ${connParams.apiModule}
    ...     '${connParams.username}/${connParams.password}@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=${connParams.host})(PORT=${connParams.port}))(CONNECT_DATA=(SERVER=DEDICATED)(SERVICE_NAME=${connParams.service})))'

Check if exists in Table
    [Arguments]  ${table}  ${column}  ${value}
    ${query}  Set Variable  SELECT ${column} FROM ${table} WHERE ${column} = '${value}'
    Check If Exists In Database  selectStatement=${query}

Query through SQL script
    [Documentation]  Formata um template de requisição sql com os parâmetros desejados
    ...              e executa uma chamada no banco utilizando o template formatado.
    [Arguments]  ${sqlSetup}

    Connect Database  ${sqlSetup.connParams}

    # Transforma a lista de colunas em uma string com os itens separados por vírgula
    ${columns}  Evaluate  ", ".join(${sqlSetup.columns})

    # Verifica se foi passado algum filtro em sqlSetup
    ${filters}  Set Variable  ${EMPTY}
    IF  "filters" in ${sqlSetup}
        ${filters}  Evaluate  " ".join(${sqlSetup.filters})
    END
    
    # Formata o template solicitado com os parâmetros informados
    ${query}   Format String  template=${sqlSetup.template}  table=${sqlSetup.table}  columns=${columns}  amount=${sqlSetup.amount}  filters=${filters}
    
    # Executa a solicitação no banco utilizando o template formatado
    ${result}  Query  selectStatement=${query}
    
    Disconnect From Database

    [Return]  ${result}


