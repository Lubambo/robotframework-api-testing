*** Settings ***
Documentation  Roteador de criação de parâmetros de conexão com os bancos de dados.

Resource  ./connections/DbOneConnection.robot
Resource  ./connections/DbTwoConnection.robot
Resource  ${EXECDIR}/resources/common/database/ConnectionsRouter.robot

Library  Collections

*** Keywords ***
Create Oracle Base Connection
    ${oracleConn}  Create Base Connection  apiModule=${project['database']['dbApi']}
    ...            service=${project['database']['dbService']}
    ...            host=${project['database']['dbHost']}
    ...            port=${project['database']['dbPort']}
    [Return]  ${oracleConn}

Set DB Connection Params
    [Arguments]  ${dbName}

    ${oracleConn}  Create Oracle Base Connection

    ${dbOne}       DbOneConnection.Create Connection  ${oracleConn}
    &{dbsInfos}    Create Dictionary  dbOne=&{dbOne}
    
    &{dbTwo}       DbTwoConnection.Create Connection  ${oracleConn}
    Set To Dictionary  ${dbsInfos}  dbTwo=&{dbTwo}

    ${params}      Get DB Connection Params  ${dbName}  &{dbsInfos}

    [Return]  ${params}
